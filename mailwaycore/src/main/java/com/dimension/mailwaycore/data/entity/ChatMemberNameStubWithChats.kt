package com.dimension.mailwaycore.data.entity

import androidx.room.Embedded
import androidx.room.Junction
import androidx.room.Relation
import kotlinx.serialization.Serializable

@Serializable
data class ChatMemberNameStubWithChats(
    @Embedded val chatMemberNameStub: ChatMemberNameStub,
    @Relation(
        parentColumn = "chatMemberNameStubId",
        entityColumn = "chatId",
        associateBy = Junction(ChatAndChatMemberNameStubCrossRef::class)
    )
    val chats: List<Chat>
)