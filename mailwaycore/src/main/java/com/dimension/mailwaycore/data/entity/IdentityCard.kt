package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
data class IdentityCard(
    @PrimaryKey var id: UUID,
    var identityCard: String
)