package com.dimension.mailwaycore.ntge

import android.content.Context
import com.dimension.mailwaycore.data.AppDatabase
import com.dimension.mailwaycore.data.entity.*
import com.dimension.mailwaycore.ntge.entity.*
import com.dimension.mailwaycore.utils.JSON
import com.dimension.mailwaycore.utils.fromMessagePack
import com.dimension.mailwaycore.utils.toISODateString
import com.dimension.mailwaycore.utils.toMessagePack
import com.dimension.ntge.Hmac256
import com.dimension.ntge.ed25519.Ed25519Keypair
import com.dimension.ntge.ed25519.Ed25519PrivateKey
import com.dimension.ntge.ed25519.Ed25519PublicKey
import com.dimension.ntge.message.Decryptor
import com.dimension.ntge.message.Encryptor
import com.dimension.ntge.message.Message
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.serialization.builtins.list
import kotlinx.serialization.builtins.serializer
import org.koin.java.KoinJavaComponent
import java.io.File
import java.util.*

class NtgeMethodCallHandler(private val scope: CoroutineScope, private val context: Context) :
    MethodChannel.MethodCallHandler {

    private val database by KoinJavaComponent.inject(AppDatabase::class.java)

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
                    JSON.parse(String.serializer().list, it)
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

                val pubkeys =
                    recipients.map { Ed25519PublicKey.deserialize(it) } + Ed25519PublicKey.deserialize(
                        sender.public_key
                    )
                val prikey = Ed25519PrivateKey.deserialize(sender.private_key!!)
                val encResult = run {
                    val x25519pubkeys = pubkeys.map { it.toX25519() }.toTypedArray()
                    Encryptor.new(*x25519pubkeys).use { encryptor ->
                        encryptor.encryptPlaintextWithExtra(
                            message.toByteArray(Charsets.UTF_8),
                            extra = MailwayMessageExtra(
                                version = 1,
                                sender_key = sender.public_key,
                                recipient_keys = recipients,
                                message_id = messageId,
                                payload_kind = PayloadKind.plaintext,
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
            "mailway_message_decode" -> {
                val message = call.argument<String>("message") ?: run {
                    result.error("01", "argument exception", "require content to decode")
                    return
                }
                scope.launch {

                    database.contactDao().getContactsWithPrivateKey().forEach {
                        runCatching {
                            Message.deserialize(message).use { ntgeMessage ->
                                Ed25519PrivateKey.deserialize(it.keypair.private_key!!)
                                    .use { ed25519PrivateKey ->
                                        ed25519PrivateKey.toX25519()
                                    }.use { x25519PrivateKey ->
                                        Decryptor.new(ntgeMessage).use { decryptor ->
                                            decryptor.getFileKey(x25519PrivateKey)
                                                .use { x25519FileKey ->
                                                    decryptor.decryptPayload(x25519FileKey) to decryptor.decryptPayloadExtra(
                                                        x25519FileKey
                                                    )
                                                }
                                        }
                                    }
                            }
                        }.onFailure {
                            it.printStackTrace()
                        }.onSuccess { data ->
                            val extra = data.second.fromMessagePack<MailwayMessageExtra>()
                            val decResult = if (extra.payload_kind == PayloadKind.plaintext) {
                                data.first.toString(Charsets.UTF_8)
                            } else {
                                val fileName = UUID.randomUUID().toString()
                                File(context.dataDir, fileName).let { file ->
                                    file.createNewFile()
                                    file.writeBytes(data.first)
                                }
                                fileName
                            }
                            val quoteDigest = if (extra.quote_message != null) {
                                if (extra.quote_message.digest_kind == PayloadKind.plaintext) {
                                    extra.quote_message.digest.toString(Charsets.UTF_8)
                                } else {
                                    val fileName = UUID.randomUUID().toString()
                                    File(context.dataDir, fileName).let { file ->
                                        file.createNewFile()
                                        file.writeBytes(extra.quote_message.digest)
                                    }
                                    fileName
                                }
                            } else {
                                null
                            }

                            result.success(DecodeResult(decResult, MailwayMessageExtra2(
                                version = extra.version,
                                sender_key = extra.sender_key,
                                payload_kind = extra.payload_kind,
                                recipient_keys = extra.recipient_keys,
                                message_id = extra.message_id,
                                quote_message = extra.quote_message?.let {
                                    MailwayExtraQuoteMessage2(
                                        id = it.id,
                                        digest = quoteDigest ?: "",
                                        digest_kind = it.digest_kind,
                                        digest_description = it.digest_description,
                                        sender_name = it.sender_name,
                                        sender_public_key = it.sender_public_key
                                    )
                                }
                            )).let { decodeResult ->
                                JSON.stringify(DecodeResult.serializer(), decodeResult)
                            })
                            return@launch
                        }
                    }
                    result.error("06", "cannot decode message", "private key not found")
                    return@launch
                }
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
            "insert_identity_card" -> {
                val content = call.argument<String>("content") ?: run {
                    result.error(
                        "01",
                        "argument exception",
                        "require content to parse contact card"
                    )
                    return
                }
                val data = content.toIdentityCardData()
                val keyId = data.info?.public_key_armor?.let {
                    Ed25519PublicKey.deserialize(it)
                }?.use {
                    it.keyId
                } ?: run {
                    result.error(
                        "01",
                        "argument exception",
                        "invalid identity content"
                    )
                    return
                }
                val mac = data.info?.mac
                val signature = data.info?.signature
                if (mac == null || signature == null) {
                    result.error(
                        "01",
                        "argument exception",
                        "invalid identity content"
                    )
                    return
                }
                if (!Ed25519PublicKey.deserialize(data.info.public_key_armor)
                        .verify(mac, signature)
                ) {
                    result.error(
                        "05",
                        "argument exception",
                        "verify identity content failed"
                    )
                    return
                }

                scope.launch {
                    if (database.contactDao()
                            .findContactWithPublicKey(data.info.public_key_armor) != null
                    ) {
                        result.error(
                            "06",
                            "already exists",
                            "contact already exists"
                        )
                        return@launch
                    }
                    val contact = Contact(
                        id = UUID.randomUUID().toString(),
                        name = data.info.name ?: data.supplementation?.name ?: "",
                        avatar = null,
                        note = null,
                        color = null,
                        created_at = System.currentTimeMillis(),
                        updated_at = System.currentTimeMillis(),
                        i18nNames = (data.info?.i18n_names
                            ?: emptyMap()) + (data.supplementation?.i18n_names
                            ?: emptyMap())
                    )
                    val keypair = Keypair(
                        id = UUID.randomUUID().toString(),
                        public_key = data.info.public_key_armor ?: "",
                        key_id = keyId,
                        created_at = System.currentTimeMillis(),
                        updated_at = System.currentTimeMillis(),
                        contactId = contact.id,
                        private_key = null
                    )
                    val contactChannels = ((data.info.channels
                        ?: emptyList()) + (data.supplementation?.channels
                        ?: emptyList())).map {
                        ContactChannel(
                            id = UUID.randomUUID().toString(),
                            name = it.name ?: "",
                            value = it.value ?: "",
                            created_at = System.currentTimeMillis(),
                            updated_at = System.currentTimeMillis(),
                            contactId = contact.id
                        )
                    }
                    val identityCard = IdentityCard(
                        id = UUID.randomUUID().toString(),
                        contactId = contact.id,
                        identityCard = content
                    )
                    database.contactDao().insert(contact)
                    database.contactDao().insert(keypair)
                    database.contactDao().insert(identityCard)
                    contactChannels?.let {
                        database.contactDao().insert(*it.toTypedArray())
                    }
                    result.success(true)
                }
            }
            "generate_share_contact" -> {
                val id = call.argument<String>("contactId") ?: run {
                    result.error(
                        "01",
                        "argument exception",
                        "require content to parse contact card"
                    )
                    return
                }
                scope.launch {
                    val data =
                        database.contactDao().getIdentityCardByContactId(id)?.identityCard ?: run {
                            val contact = database.contactDao().queryContact(id)
                            val mac = run {
                                var bytes =
                                    contact.keypair.public_key.toByteArray() + contact.contact.name.toByteArray()
                                contact.contact.i18nNames?.let { names ->
                                    bytes += names.toList().sortedBy { it.first.toLowerCase() }
                                        .map {
                                            it.first.toLowerCase()
                                                .toByteArray() + it.second.toByteArray()
                                        }.flatMap { it.toList() }
                                }
                                contact.channels.let { channels ->
                                    bytes += channels.map { it.name.toByteArray() + it.value.toByteArray() }
                                        .flatMap { it.toList() }
                                }
                                bytes += contact.contact.updated_at.toISODateString().toByteArray()
                                Ed25519PublicKey.deserialize(contact.keypair.public_key)
                                    .use { ed25519PublicKey ->
                                        Hmac256.calculate(ed25519PublicKey, bytes)
                                    }
                            }
                            val signature =
                                Ed25519PrivateKey.deserialize(contact.keypair.private_key!!).use {
                                    it.sign(mac)
                                }
                            IdentityCardData(
                                info = IdentityInfo(
                                    public_key_armor = contact.keypair.public_key,
                                    name = contact.contact.name,
                                    i18n_names = contact.contact.i18nNames,
                                    channels = contact.channels.map {
                                        IdentityChannel(
                                            name = it.name,
                                            value = it.value
                                        )
                                    },
                                    updated_at = contact.contact.updated_at.toISODateString(),
                                    mac = mac,
                                    signature = signature
                                ),
                                supplementation = null
                            ).toString()
                        }
                    result.success(data)
                }
            }
            else -> result.notImplemented()
        }
    }
}
