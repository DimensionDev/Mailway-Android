package com.dimension.mailwaycore.ui.scene

import androidx.compose.Composable
import androidx.ui.core.Alignment
import androidx.ui.core.Modifier
import androidx.ui.foundation.Image
import androidx.ui.foundation.Text
import androidx.ui.foundation.VerticalScroller
import androidx.ui.foundation.clickable
import androidx.ui.graphics.vector.VectorAsset
import androidx.ui.layout.*
import androidx.ui.material.icons.Icons
import androidx.ui.material.icons.filled.AccountBox
import androidx.ui.material.icons.filled.Build
import androidx.ui.material.icons.filled.Email
import androidx.ui.material.icons.filled.Settings
import androidx.ui.tooling.preview.Preview
import androidx.ui.unit.dp
import com.dimension.mailwaycore.ui.Screen
import com.dimension.mailwaycore.ui.navigateTo


@Preview(showBackground = true)
@Composable
fun buildHomeDrawer() {
    Column {
        VerticalScroller(
            modifier = Modifier.weight(1.0F)
        ) {
            Spacer(modifier = Modifier.preferredHeight(16.dp))
            buildDrawerMenu(
                icon = Icons.Default.AccountBox,
                title = "InBox"
            ) {
                navigateTo(Screen.Inbox)
            }
            buildDrawerMenu(icon = Icons.Default.Email, title = "Drafts") {

            }
            buildDrawerMenu(icon = Icons.Default.AccountBox, title = "Contacts") {
                navigateTo(Screen.Contacts)
            }
            buildDrawerMenu(icon = Icons.Default.Build, title = "Plugins") {

            }
        }

        buildDrawerMenu(icon = Icons.Default.Settings, title = "Settings") {

        }
        Spacer(modifier = Modifier.preferredHeight(16.dp))
    }
}


@Composable
fun buildDrawerMenu(
    icon: VectorAsset,
    title: String,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onClick)
            .padding(horizontal = 32.dp, vertical = 16.dp)
    ) {
        Image(asset = icon)
        Spacer(modifier = Modifier.preferredWidth(16.dp))
        Text(
            modifier = Modifier.gravity(Alignment.CenterVertically),
            text = title
        )
    }
}