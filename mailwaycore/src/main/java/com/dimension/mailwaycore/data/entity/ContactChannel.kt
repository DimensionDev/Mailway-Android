package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class ContactChannel(
    @PrimaryKey var id: String,
    var name: String,
    var value: String,
    var created_at: Long,
    var updated_at: Long,
    var contactId: String
)