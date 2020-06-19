package com.dimension.mailwaycore.data.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
data class Contact(
    @PrimaryKey var id: UUID,
    var name: String,
    @ColumnInfo(typeAffinity = ColumnInfo.BLOB)
    var avatar: ByteArray?,
    var note: String?,
    var created_at: Date,
    var updated_at: Date,
    var i18nNames: Map<String, String>
)


