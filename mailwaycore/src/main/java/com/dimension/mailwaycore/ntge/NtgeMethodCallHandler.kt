package com.dimension.mailwaycore.ntge

import com.dimension.mailwaycore.data.entity.Keypair
import com.dimension.mailwaycore.data.entity.PayloadKind
import com.dimension.mailwaycore.utils.JSON
import com.dimension.mailwaycore.utils.fromMessagePack
import com.dimension.mailwaycore.utils.toMessagePack
import com.dimension.ntge.Base58
import com.dimension.ntge.ed25519.Ed25519Keypair
import com.dimension.ntge.ed25519.Ed25519PrivateKey
import com.dimension.ntge.ed25519.Ed25519PublicKey
import com.dimension.ntge.message.Decryptor
import com.dimension.ntge.message.Encryptor
import com.dimension.ntge.message.Message
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.KotlinModule
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.serialization.Serializable
import kotlinx.serialization.builtins.ByteArraySerializer
import kotlinx.serialization.builtins.list
import org.msgpack.jackson.dataformat.MessagePackFactory

class NtgeMethodCallHandler : MethodChannel.MethodCallHandler {
    companion object {
        val CHANNEL = "com.dimension.mailwaycore/ntge"
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "keypair_generate" -> {
                val keypair = Ed25519Keypair.new()
                result.success(
                    JSON.stringify(
                        NtgeEd25519Keypair.serializer(), NtgeEd25519Keypair(
                            keyId = keypair.publicKey.keyId,
                            publicKey = keypair.publicKey.serialize(),
                            privateKey = keypair.privateKey.serialize()
                        )
                    )
                )
            }
            "message_encode" -> {
                val message = call.argument<String>("content") ?: run {
                    result.error("01", "argument exception", "require content to encode")
                    return
                }
                val recipients = call.argument<List<String>>("recipient") ?: run {
                    result.error("01", "argument exception", "require public keys to encode")
                    return
                }
                val sender = call.argument<String>("sender") ?: run {
                    result.error("01", "argument exception", "require private key to encode")
                    return
                }
                val pubkeys = recipients.map { Ed25519PublicKey.deserialize(it) }
                val prikey = Ed25519PrivateKey.deserialize(sender)
                val encResult = run {
                    val x25519pubkeys = pubkeys.map { it.toX25519() }.toTypedArray()
                    Encryptor.new(*x25519pubkeys).use { encryptor ->
                        encryptor.encryptPlaintext(message, signatureKey = prikey)
                    }.also {
                        x25519pubkeys.forEach { it.close() }
                    }
                }.use {
                    it.serialize()
                }
                result.success(encResult)
            }
            "mailway_message_encode" -> {
                val message = call.argument<String>("content") ?: run {
                    result.error("01", "argument exception", "require content to encode")
                    return
                }
                val messageId = call.argument<String>("message_id") ?: run {
                    result.error("01", "argument exception", "require message_id to encode")
                    return
                }
                val recipients = call.argument<String>("recipient")?.let {
                    JSON.parse(Keypair.serializer().list, it)
                } ?: run {
                    result.error("01", "argument exception", "require public keys to encode")
                    return
                }
                val sender = call.argument<String>("sender")?.let {
                    JSON.parse(Keypair.serializer(), it)
                } ?: run {
                    result.error("01", "argument exception", "require private key to encode")
                    return
                }

                val pubkeys = recipients.map { Ed25519PublicKey.deserialize(it.public_key) }
                val prikey = Ed25519PrivateKey.deserialize(sender.private_key!!)
                val encResult = run {
                    val x25519pubkeys = pubkeys.map { it.toX25519() }.toTypedArray()
                    Encryptor.new(*x25519pubkeys).use { encryptor ->
                        encryptor.encryptPlaintextWithExtra(
                            message.toByteArray(Charsets.UTF_8),
                            extra = MailwayMessageExtra(
                                version = 1,
                                sender_key = sender.public_key,
                                recipient_keys = recipients.map { it.public_key },
                                message_id = messageId,
                                quote_message = null
                            ).toMessagePack(),
                            signatureKey = prikey
                        )
                    }.also {
                        x25519pubkeys.forEach { it.close() }
                    }
                }.use {
                    it.serialize()
                }
                result.success(encResult)
            }
            "message_decode" -> {
                val message = call.argument<String>("content") ?: run {
                    result.error("01", "argument exception", "require content to decode")
                    return
                }
                val privateKey = call.argument<String>("privateKey") ?: run {
                    result.error("01", "argument exception", "require private key to encode")
                    return
                }
                val decResult = Ed25519PrivateKey.deserialize(privateKey).use { ed25519PrivateKey ->
                    Message.deserialize(message).use { message ->
                        Decryptor.new(message).use { decryptor ->
                            ed25519PrivateKey.toX25519().use { x25519PrivateKey ->
                                decryptor.getFileKey(x25519PrivateKey).use { x25519FileKey ->
                                    decryptor.decryptPayload(x25519FileKey)
                                }
                            }
                        }
                    }
                }
                result.success(decResult)
            }
            "parse_contact_card" -> {
                val content = call.argument<String>("content") ?: run {
                    result.error(
                        "01",
                        "argument exception",
                        "require content to parse contact card"
                    )
                    return
                }
                if (!content.startsWith("IdCardBeginII") || !content.endsWith("IIEndIdCard")) {
                    result.error("03", "argument exception", "invalid card content")
                    return
                }
                val base58 = content.removePrefix("IdCardBeginII").removeSuffix("IIEndIdCard")
                val messagePack = Base58.decode(base58)
                if (messagePack == null) {
                    result.error("04", "invalid base58", null)
                    return
                }
                val cardResult = messagePack.fromMessagePack<IdentityCardData>()
                result.success(JSON.stringify(IdentityCardData.serializer(), cardResult))
            }
            else -> result.notImplemented()
        }
    }

}

@Serializable
data class MailwayMessageExtra(
    val version: Int,
    val sender_key: String,
    val recipient_keys: List<String>,
    val message_id: String,
    val quote_message: MailwayExtraQuoteMessage?
)

@Serializable
data class MailwayExtraQuoteMessage(
    val id: String,
    val digest: ByteArray,
    val digest_kind: PayloadKind,
    val digest_description: String,
    val sender_name: String,
    val sender_public_key: String
)


@Serializable
data class NtgeEd25519Keypair(
    val keyId: String,
    val publicKey: String,
    val privateKey: String
)

@Serializable
@JsonIgnoreProperties(ignoreUnknown = true)
data class IdentityCardData(
    val info: IdentityInfo?,
    val supplementation: IdentitySupplementation?
)

@Serializable
data class IdentitySupplementation(
    val name: String?,
    val i18nNames: Map<String, String>?,
    val channels: List<IdentityChannel>?,
    val updatedAt: String?
)

@Serializable
data class IdentityChannel(
    val name: String?,
    val value: String?
)

@Serializable
data class IdentityInfo(
    val public_key_armor: String?,
    val name: String?,
    val i18nNames: Map<String, String>?,
    val channels: List<IdentityChannel>?,
    val updatedAt: String?,
    val mac: ByteArray?,
    val signature: ByteArray?
)