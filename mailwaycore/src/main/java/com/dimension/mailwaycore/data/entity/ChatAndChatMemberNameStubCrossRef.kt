package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import kotlinx.serialization.Serializable

@Serializable
@Entity(primaryKeys = ["chatId", "chatMemberNameStubId"])
data class ChatAndChatMemberNameStubCrossRef(
    val chatId: String,
    val chatMemberNameStubId: String
)