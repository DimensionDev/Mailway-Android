package com.dimension.mailwaycore.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.Serializable

@Entity
@Serializable
data class Contact(
    @PrimaryKey var id: String,
    var name: String,
    var avatar: String?,
    var note: String?,
    var created_at: Long,
    var updated_at: Long,
    var i18nNames: Map<String, String>
)


