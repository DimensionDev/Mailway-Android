package com.dimension.mailwaycore.ui.scene

import androidx.compose.Composable
import androidx.compose.getValue
import androidx.compose.state
import androidx.ui.core.Modifier
import androidx.ui.core.clip
import androidx.ui.foundation.AdapterList
import androidx.ui.foundation.Icon
import androidx.ui.foundation.Text
import androidx.ui.foundation.shape.corner.RoundedCornerShape
import androidx.ui.graphics.Color
import androidx.ui.layout.*
import androidx.ui.livedata.observeAsState
import androidx.ui.material.*
import androidx.ui.material.icons.Icons
import androidx.ui.material.icons.filled.Add
import androidx.ui.material.icons.filled.Menu
import androidx.ui.material.icons.filled.Search
import androidx.ui.tooling.preview.Preview
import androidx.ui.unit.dp
import com.dimension.mailwaycore.data.DatabaseAmbient
import com.dimension.mailwaycore.ui.Screen
import com.dimension.mailwaycore.ui.navigateTo

@Preview
@Composable
fun ContactScene() {
    val (drawerState, setDrawerState) = state {
        DrawerState.Closed
    }

    val database = DatabaseAmbient.current
    val contacts by database.contactDao().getContactsSync().observeAsState(initial = emptyList())

    Scaffold(
        scaffoldState = ScaffoldState(drawerState),
        topAppBar = {
            TopAppBar(
                backgroundColor = MaterialTheme.colors.background,
                title = {
                    Text("Contacts")
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
            FloatingActionButton(
                onClick = {
                    navigateTo(Screen.AddContacts)
                }
            ) {
                Icon(
                    asset = Icons.Default.Add,
                    tint = Color.White
                )
            }
        }
    ) {
        AdapterList(
            data = contacts
        ) {
            Row {
                Surface(
                    contentColor = MaterialTheme.colors.onPrimary,
                    color = MaterialTheme.colors.primary,
                    modifier = Modifier
                        .padding(8.dp)
                        .aspectRatio(1.0F)
                        .clip(RoundedCornerShape(100.dp))
                ) {
                    Text(text = it.name.first().toUpperCase().toString())
                }
                Spacer(modifier = Modifier.preferredWidth(16.dp))
                Text(text = it.name)
            }
        }
    }
}