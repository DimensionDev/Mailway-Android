package com.dimension.mailwaycore.ui.scene

import androidx.compose.Composable
import androidx.compose.getValue
import androidx.compose.state
import androidx.ui.animation.animate
import androidx.ui.core.*
import androidx.ui.foundation.AdapterList
import androidx.ui.foundation.Box
import androidx.ui.foundation.Icon
import androidx.ui.foundation.Text
import androidx.ui.foundation.shape.corner.RoundedCornerShape
import androidx.ui.graphics.Color
import androidx.ui.layout.*
import androidx.ui.layout.RowScope.gravity
import androidx.ui.livedata.observeAsState
import androidx.ui.material.*
import androidx.ui.material.icons.Icons
import androidx.ui.material.icons.filled.*
import androidx.ui.tooling.preview.Preview
import androidx.ui.unit.dp
import com.dimension.mailwaycore.data.DatabaseAmbient


@Preview(showBackground = true)
@Composable
fun HomeScene() {
    val (drawerState, setDrawerState) = state {
        DrawerState.Closed
    }
    val database = DatabaseAmbient.current
    val messages by database.chatDao().getChatWithChatMessagesSync().observeAsState(initial = emptyList())

    Scaffold(
        scaffoldState = ScaffoldState(drawerState),
        topAppBar = {
            TopAppBar(
                backgroundColor = MaterialTheme.colors.background,
                title = {
                    Text("Inbox")
                },
                actions = {
                    IconButton(onClick = {}) {
                        Icon(asset = Icons.Default.Search)
                    }
                },
                navigationIcon = {
                    IconButton(onClick = {
                        setDrawerState(
                            when (drawerState) {
                                DrawerState.Closed -> DrawerState.Opened
                                DrawerState.Opened -> DrawerState.Closed
                            }
                        )
                    }) {
                        Icon(asset = Icons.Default.Menu)
                    }
                })
        },
        drawerContent = {
            buildHomeDrawer()
        },
        floatingActionButton = {
            buildFloatingActionButton()
        }
    ) {
        AdapterList(
            data = messages
        ) {
            Row {
                Surface(
                    contentColor = MaterialTheme.colors.onPrimary,
                    color = MaterialTheme.colors.primary,
                    modifier = Modifier
                        .aspectRatio(1.0F)
                        .padding(8.dp)
                        .clip(RoundedCornerShape(100.dp))
                ) {
                    Text(text = it.chat.title.first().toUpperCase().toString())
                }
                Spacer(modifier = Modifier.preferredWidth(16.dp))
                Column {
                    Text(text = it.chat.title)
                    Text(text = it.messages.lastOrNull()?.armored_message ?: "")
                }
            }
        }
    }
}


@Composable
fun buildFloatingActionButton() {
    val (expanded, setExpanded) = state {
        false
    }

    val degrees = animate(if (expanded) 270.0F - 45.0F else 0.0F)
    val opacity = animate(if (expanded) 1.0F else 0.0F)

    Column(
        horizontalGravity = Alignment.End
    ) {
        Row(
            modifier = Modifier
                .padding(bottom = 16.dp, end = 4.dp)
                .drawOpacity(opacity)
        ) {
            Box(
                modifier = Modifier
                    .gravity(Alignment.CenterVertically)
                    .clip(RoundedCornerShape(4.dp)),
                backgroundColor = Color.DarkGray.copy(alpha = 0.87F)
            ) {
                Text(
                    modifier = Modifier
                        .padding(horizontal = 8.dp, vertical = 4.dp),
                    text = "Receive",
                    color = Color.White
                )
            }
            Spacer(modifier = Modifier.preferredWidth(16.dp))
            FloatingActionButton(
                elevation = 0.dp,
                backgroundColor = Color.Blue,
                modifier = Modifier.size(48.dp),
                onClick = {
                    setExpanded(!expanded)
                }) {
                Icon(
                    asset = Icons.Default.AccountBox,
                    tint = Color.White
                )
            }
        }
        Row(
            modifier = Modifier
                .padding(bottom = 16.dp, end = 4.dp)
                .gravity(Alignment.CenterVertically)
                .drawOpacity(opacity)
        ) {
            Box(
                modifier = Modifier
                    .gravity(Alignment.CenterVertically)
                    .clip(RoundedCornerShape(4.dp)),
                backgroundColor = Color.DarkGray.copy(alpha = 0.87F)
            ) {
                Text(
                    modifier = Modifier
                        .padding(horizontal = 8.dp, vertical = 4.dp),
                    text = "Compose",
                    color = Color.White
                )
            }
            Spacer(modifier = Modifier.preferredWidth(16.dp))
            FloatingActionButton(
                elevation = 0.dp,
                backgroundColor = Color.Green,
                modifier = Modifier.size(48.dp),
                onClick = {
                    setExpanded(!expanded)
                }) {
                Icon(
                    asset = Icons.Default.Send,
                    tint = Color.White
                )
            }
        }
        FloatingActionButton(
            onClick = {
                setExpanded(!expanded)
            }) {
            Icon(
                modifier = Modifier.drawLayer(rotationZ = degrees),
                asset = Icons.Default.Add,
                tint = Color.White
            )
        }
    }
}