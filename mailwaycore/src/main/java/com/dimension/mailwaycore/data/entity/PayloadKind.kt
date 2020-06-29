package com.dimension.mailwaycore.data.entity

import kotlinx.serialization.Serializable

@Serializable
enum class PayloadKind {
    plaintext,
    image,
    video,
    audio,
    other,
}