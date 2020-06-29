package com.dimension.mailwaycore.data

import androidx.room.TypeConverter
import com.dimension.mailwaycore.data.entity.PayloadKind
import com.dimension.mailwaycore.utils.JSON
import kotlinx.serialization.builtins.MapSerializer
import kotlinx.serialization.builtins.list
import kotlinx.serialization.builtins.serializer

class Converters {
    @TypeConverter
    fun listToJson(value: List<String>?) =
        value?.let { JSON.stringify(String.serializer().list, it) }

    @TypeConverter
    fun jsonToList(value: String?) = value?.let { JSON.parse(String.serializer().list, it) }

//    @TypeConverter
//    fun fromTimestamp(value: Long?) = value?.let { Date(it) }
//
//    @TypeConverter
//    fun dateToTimestamp(date: Date?) = date?.time

//    @TypeConverter
//    fun stringToUUID(value: String?) = value?.let { UUID.fromString(it) }
//
//    @TypeConverter
//    fun fromUUID(value: String?) = value?.toString()

    @TypeConverter
    fun stringToPayloadKind(value: String?) = value?.let { PayloadKind.valueOf(it) }

    @TypeConverter
    fun fromPayloadKind(value: PayloadKind?) = value?.name

    @TypeConverter
    fun stringToMap(value: String?) = value?.let { JSON.parse(MapSerializer(String.serializer(), String.serializer()), value) }

    @TypeConverter
    fun fromMap(value: Map<String, String>?) = value?.let { JSON.stringify(MapSerializer(String.serializer(), String.serializer()) ,it) }

}