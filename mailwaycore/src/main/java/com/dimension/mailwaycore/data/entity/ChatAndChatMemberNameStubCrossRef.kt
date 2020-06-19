package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity(primaryKeys = ["chatId", "chatMemberNameStubId"])
data class ChatAndChatMemberNameStubCrossRef(
    val chatId: UUID,
    val chatMemberNameStubId: UUID
)