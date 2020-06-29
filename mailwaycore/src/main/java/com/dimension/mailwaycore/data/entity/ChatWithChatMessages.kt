package com.dimension.mailwaycore.data.entity

import androidx.room.Embedded
import androidx.room.Relation
import kotlinx.serialization.Serializable

@Serializable
data class ChatWithChatMessages(
    @Embedded val chat: Chat,
    @Relation(
        parentColumn = "chatId",
        entityColumn = "chatId"
    )
    val messages: List<ChatMessage>
)