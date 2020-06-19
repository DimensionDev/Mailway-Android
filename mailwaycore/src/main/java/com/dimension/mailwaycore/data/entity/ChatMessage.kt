package com.dimension.mailwaycore.data.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
data class ChatMessage(
    @PrimaryKey var id: UUID,
    var created_at: Date,
    var updated_at: Date,
    var message_timestamp: Date,
    var compose_timestamp: Date?,
    var receive_timestamp: Date,
    var share_timestamp: Date?,
    var sender_public_key: String,
    var recipient_public_keys: List<String>,
    var armored_message: String,
    @ColumnInfo(typeAffinity = ColumnInfo.BLOB)
    var payload: ByteArray?,
    var payload_kind: PayloadKind,
    var version: Int?,
    var chatId: UUID
)