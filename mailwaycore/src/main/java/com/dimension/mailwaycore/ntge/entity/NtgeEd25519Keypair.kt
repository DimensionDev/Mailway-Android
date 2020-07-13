package com.dimension.mailwaycore.ntge.entity

import kotlinx.serialization.Serializable

@Serializable
data class NtgeEd25519Keypair(
    val keyId: String,
    val publicKey: String,
    val privateKey: String
)