package com.dimension.mailwaycore.data.entity

import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.Relation

data class ChatWithChatMessages(
    @Embedded val chat: Chat,
    @Relation(
        parentColumn = "chatId",
        entityColumn = "chatId"
    )
    val messages: List<ChatMessage>
)