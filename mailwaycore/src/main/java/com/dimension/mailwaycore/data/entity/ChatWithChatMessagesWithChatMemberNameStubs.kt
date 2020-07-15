package com.dimension.mailwaycore.data.entity

import androidx.room.Embedded
import androidx.room.Junction
import androidx.room.Relation
import kotlinx.serialization.Serializable


@Serializable
data class ChatWithChatMessagesWithChatMemberNameStubs(
    @Embedded val chat: Chat,
    @Relation(
        entity = ChatMessage::class,
        parentColumn = "chatId",
        entityColumn = "chatId"
    )
    val messages: List<ChatMessageAndQuoteMessage>,
    @Relation(
        parentColumn = "chatId",
        entityColumn = "chatMemberNameStubId",
        associateBy = Junction(ChatAndChatMemberNameStubCrossRef::class)
    )
    val chatMemberNameStubs: List<ChatMemberNameStub>
)