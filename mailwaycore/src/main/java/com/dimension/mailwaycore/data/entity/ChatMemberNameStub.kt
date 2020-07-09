package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class ChatMemberNameStub(
    @PrimaryKey var chatMemberNameStubId: String,
    var key_id: String,
    var public_key: String,
    var name: String,
    var created_at: Long,
    var updated_at: Long,
    var i18nNames: Map<String, String>?
)

