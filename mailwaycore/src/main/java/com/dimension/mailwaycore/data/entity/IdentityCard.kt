package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class IdentityCard(
    @PrimaryKey var id: String,
    var identityCard: String
)