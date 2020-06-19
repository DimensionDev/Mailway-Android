package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
data class Chat(
    @PrimaryKey var chatId: UUID,
    var title: String,
    var identity_public_key: String,
    var created_at: Date,
    var updated_at: Date
)