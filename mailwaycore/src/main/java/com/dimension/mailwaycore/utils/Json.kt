package com.dimension.mailwaycore.utils

import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration

val JSON by lazy {
    Json(JsonConfiguration.Stable)
}
