package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
data class ChatMemberNameStub(
    @PrimaryKey var chatMemberNameStubId: UUID,
    var key_id: String,
    var public_key: String,
    var name: String,
    var created_at: Date,
    var updated_at: Date,
    var i18nNames: Map<String, String>
)