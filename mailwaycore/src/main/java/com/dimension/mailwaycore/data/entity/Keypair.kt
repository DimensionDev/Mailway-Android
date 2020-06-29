package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class Keypair(
    @PrimaryKey var id: String,
    var key_id: String,
    var private_key: String?,
    var public_key: String,
    var created_at: Long,
    var updated_at: Long,
    var contactId: String
)