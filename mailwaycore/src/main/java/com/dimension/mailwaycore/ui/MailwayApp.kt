package com.dimension.mailwaycore.ui

import androidx.compose.Composable
import androidx.ui.animation.Crossfade
import androidx.ui.core.ContextAmbient
import androidx.ui.material.MaterialTheme
import androidx.ui.material.Surface
import com.dimension.mailwaycore.ui.scene.AddContact
import com.dimension.mailwaycore.ui.scene.ContactScene
import com.dimension.mailwaycore.ui.scene.HomeScene

@Composable
fun MailwayApp() {
    MailWayTheme {
        AppContent()
    }
}

@Composable
fun AppContent() {
    ContextAmbient.current
    Crossfade(MailwayStatus.currentScreen) { screen ->
        Surface(color = MaterialTheme.colors.background) {
            when (screen) {
                Screen.Inbox -> HomeScene()
                Screen.Contacts -> ContactScene()
                Screen.AddContacts -> AddContact()
            }
        }
    }
}

