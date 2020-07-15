package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.fasterxml.jackson.annotation.JsonIgnore
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class QuoteMessage(
    @PrimaryKey
    @JsonIgnore
    var id: String,
    var created_at: Long,
    var updated_at: Long,
    var chatMessageId: String,
    var message_id: String,
    var digest: String,
    var digest_kind: PayloadKind,
    var digest_description: String,
    var sender_name: String,
    var sender_public_key: String
)