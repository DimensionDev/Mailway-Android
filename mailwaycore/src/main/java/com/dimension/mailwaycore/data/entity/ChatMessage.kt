package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class ChatMessage(
    @PrimaryKey var id: String,
    var created_at: Long,
    var updated_at: Long,
    var message_timestamp: Long,
    var compose_timestamp: Long?,
    var receive_timestamp: Long,
    var share_timestamp: Long?,
    var sender_public_key: String,
    var recipient_public_keys: List<String>,
    var armored_message: String,
    var payload: String?,
    var payload_kind: PayloadKind,
    var version: Int?,
    var chatId: String
)