package com.dimension.mailwaycore.ntge.entity

import kotlinx.serialization.Serializable

@Serializable
data class IdentitySupplementation(
    val name: String?,
    val i18nNames: Map<String, String>?,
    val channels: List<IdentityChannel>?,
    val updatedAt: String?
)