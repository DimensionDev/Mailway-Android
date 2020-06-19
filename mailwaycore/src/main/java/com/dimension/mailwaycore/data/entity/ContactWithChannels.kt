package com.dimension.mailwaycore.data.entity

import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.Relation

data class ContactWithChannels(
    @Embedded val contact: Contact,
    @Relation(
        parentColumn = "id",
        entityColumn = "contactId"
    )
    val channels: List<ContactChannel>
)