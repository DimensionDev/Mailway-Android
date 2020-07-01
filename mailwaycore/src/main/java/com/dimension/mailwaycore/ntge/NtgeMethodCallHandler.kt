package com.dimension.mailwaycore.ntge

import com.dimension.mailwaycore.utils.JSON
import com.dimension.ntge.ed25519.Ed25519Keypair
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.serialization.Serializable

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
            else -> result.notImplemented()
        }
    }

}

@Serializable
data class NtgeEd25519Keypair(
    val keyId: String,
    val publicKey: String,
    val privateKey: String
)