package com.dimension.mailwaycore.utils

import java.text.SimpleDateFormat
import java.util.*

fun Long.toISODateString(): String {
    val tz = TimeZone.getTimeZone("UTC")
    val df = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    df.timeZone = tz
    return df.format(Date(this))
}