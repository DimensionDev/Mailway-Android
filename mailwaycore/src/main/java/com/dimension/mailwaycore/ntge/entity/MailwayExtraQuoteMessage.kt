package com.dimension.mailwaycore.ntge.entity

import com.dimension.mailwaycore.data.entity.PayloadKind
import kotlinx.serialization.Serializable

@Serializable
data class MailwayExtraQuoteMessage(
    val id: String,
    val digest: ByteArray,
    val digest_kind: PayloadKind,
    val digest_description: String,
    val sender_name: String,
    val sender_public_key: String
)