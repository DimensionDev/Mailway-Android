package com.dimension.mailwaycore.ntge.entity

import kotlinx.serialization.Serializable

@Serializable
data class IdentitySupplementation(
    val name: String?,
    val i18n_names: Map<String, String>?,
    val channels: List<IdentityChannel>?,
    val updated_at: String?
)