package com.dimension.mailwaycore.ntge.entity

import kotlinx.serialization.Serializable

@Serializable
data class MailwayMessageExtra(
    val version: Int,
    val sender_key: String,
    val recipient_keys: List<String>,
    val message_id: String,
    val quote_message: MailwayExtraQuoteMessage?
)