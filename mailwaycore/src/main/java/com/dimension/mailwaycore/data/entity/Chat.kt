package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class Chat(
    @PrimaryKey var chatId: String,
    var title: String,
    var identity_public_key: String,
    var created_at: Long,
    var updated_at: Long
)