package com.dimension.mailwaycore.ntge.entity

import kotlinx.serialization.Serializable

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