package com.dimension.mailwaycore.data.entity

import androidx.room.Embedded
import androidx.room.Junction
import androidx.room.Relation
import kotlinx.serialization.Serializable

@Serializable
data class ChatWithChatMemberNameStubs(
    @Embedded val chat: Chat,
    @Relation(
        parentColumn = "chatId",
        entityColumn = "chatMemberNameStubId",
        associateBy = Junction(ChatAndChatMemberNameStubCrossRef::class)
    )
    val chatMemberNameStubs: List<ChatMemberNameStub>
)