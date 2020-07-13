package com.dimension.mailwaycore.ntge.entity

import kotlinx.serialization.Serializable

@Serializable
data class IdentityChannel(
    val name: String?,
    val value: String?
)