package com.dimension.mailwaycore.ntge.entity

import com.dimension.mailwaycore.utils.fromMessagePack
import com.dimension.mailwaycore.utils.toMessagePack
import com.dimension.ntge.Base58
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import kotlinx.serialization.Serializable


@Serializable
@JsonIgnoreProperties(ignoreUnknown = true)
data class IdentityCardData(
    val info: IdentityInfo?,
    val supplementation: IdentitySupplementation?
) {
    override fun toString() = "IdCardBeginII${Base58.encode(toMessagePack())}IIEndIdCard"
}

fun String.toIdentityCardData(): IdentityCardData {
    if (!startsWith("IdCardBeginII") || !endsWith("IIEndIdCard")) {
        throw IllegalArgumentException()
    }
    val base58 = removePrefix("IdCardBeginII").removeSuffix("IIEndIdCard")
    val messagePack = Base58.decode(base58) ?: throw IllegalArgumentException()
    return messagePack.fromMessagePack()
}
