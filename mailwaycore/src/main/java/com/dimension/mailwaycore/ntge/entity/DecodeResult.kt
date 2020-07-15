package com.dimension.mailwaycore.ntge.entity

import com.dimension.mailwaycore.data.entity.PayloadKind
import kotlinx.serialization.Serializable

@Serializable
data class DecodeResult(
    val message: String,
    val extra: MailwayMessageExtra2
)

@Serializable
data class MailwayMessageExtra2(
    val version: Int?,
    val sender_key: String?,
    val payload_kind: PayloadKind?,
    val recipient_keys: List<String>?,
    val message_id: String?,
    val quote_message: MailwayExtraQuoteMessage2?
)

@Serializable
data class MailwayExtraQuoteMessage2(
    val id: String,
    val digest: String,
    val digest_kind: PayloadKind,
    val digest_description: String,
    val sender_name: String,
    val sender_public_key: String
)