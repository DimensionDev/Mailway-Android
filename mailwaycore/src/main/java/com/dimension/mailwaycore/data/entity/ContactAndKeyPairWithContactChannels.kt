package com.dimension.mailwaycore.data.entity

import androidx.room.Embedded
import androidx.room.Relation
import kotlinx.serialization.Serializable

@Serializable
data class ContactAndKeyPairWithContactChannels(
    @Embedded val contact: Contact,
    @Relation(
        parentColumn = "id",
        entityColumn = "contactId"
    )
    val keypair: Keypair,
    @Relation(
        parentColumn = "id",
        entityColumn = "contactId"
    )
    val channels: List<ContactChannel>
)