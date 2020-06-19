package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
data class ContactChannel(
    @PrimaryKey var id: UUID,
    var name: String,
    var value: String,
    var created_at: Date,
    var updated_at: Date,
    var contactId: UUID
)