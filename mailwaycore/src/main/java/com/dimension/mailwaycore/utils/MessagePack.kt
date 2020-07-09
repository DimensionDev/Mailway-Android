package com.dimension.mailwaycore.utils

import com.dimension.mailwaycore.ntge.IdentityCardData
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.KotlinModule
import org.msgpack.jackson.dataformat.MessagePackFactory

inline fun <reified T> T.toMessagePack(): ByteArray {
    val objectMapper = ObjectMapper(MessagePackFactory()).apply {
        registerModule(KotlinModule())
    }
    return objectMapper.writeValueAsBytes(this)
}

inline fun <reified T> ByteArray.fromMessagePack() : T {
    val objectMapper = ObjectMapper(MessagePackFactory()).apply {
        registerModule(KotlinModule())
    }
    return objectMapper.readValue<T>(this, T::class.java)
}