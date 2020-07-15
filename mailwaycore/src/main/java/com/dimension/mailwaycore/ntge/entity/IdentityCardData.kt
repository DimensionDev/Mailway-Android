package com.dimension.mailwaycore.ntge.entity

import com.dimension.mailwaycore.utils.fromMessagePack
import com.dimension.mailwaycore.utils.toMessagePack
import com.dimension.ntge.Base58
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import kotlinx.serialization.Serializable


private const val PREFIX = "BizcardBeginII"
private const val SUFFIX = "IIEndBizcard"

@Serializable
@JsonIgnoreProperties(ignoreUnknown = true)
data class IdentityCardData(
    val info: IdentityInfo?,
    val supplementation: IdentitySupplementation?
) {
    override fun toString() = "$PREFIX${Base58.encode(toMessagePack())}$SUFFIX"
}

fun String.toIdentityCardData(): IdentityCardData {
    if (!startsWith(PREFIX) || !endsWith(SUFFIX)) {
        throw IllegalArgumentException()
    }
    val base58 = removePrefix(PREFIX).removeSuffix(SUFFIX)
    val messagePack = Base58.decode(base58) ?: throw IllegalArgumentException()
    return messagePack.fromMessagePack()
}
