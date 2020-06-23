package com.dimension.mailwaycore.ui

import androidx.compose.getValue
import androidx.compose.mutableStateOf
import androidx.compose.setValue

/**
 * Class defining the screens we have in the app: home, article details and interests
 */
enum class Screen {
    Inbox,
    Contacts,
    AddContacts,
}

object MailwayStatus {
    var currentScreen by mutableStateOf(Screen.Inbox)
}

/**
 * Temporary solution pending navigation support.
 */
fun navigateTo(destination: Screen) {
    MailwayStatus.currentScreen = destination
}
