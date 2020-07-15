package com.dimension.mailwaycore.ntge.entity

import com.dimension.mailwaycore.data.entity.PayloadKind
import kotlinx.serialization.Serializable

@Serializable
data class MailwayMessageExtra(
    val version: Int?,
    val sender_key: String?,
    val payload_kind: PayloadKind?,
    val recipient_keys: List<String>?,
    val message_id: String?,
    val quote_message: MailwayExtraQuoteMessage?
)