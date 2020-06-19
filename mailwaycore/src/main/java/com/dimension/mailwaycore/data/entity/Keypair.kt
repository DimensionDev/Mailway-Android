package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
data class Keypair(
    @PrimaryKey var id: UUID,
    var key_id: String,
    var private_key: String?,
    var public_key: String,
    var created_at: Date,
    var updated_at: Date,
    var contactId: UUID
)