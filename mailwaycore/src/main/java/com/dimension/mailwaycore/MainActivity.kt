package com.dimension.mailwaycore

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.Composable
import androidx.compose.state
import androidx.ui.animation.animate
import androidx.ui.core.*
import androidx.ui.foundation.*
import androidx.ui.foundation.shape.corner.RoundedCornerShape
import androidx.ui.graphics.Color
import androidx.ui.graphics.vector.VectorAsset
import androidx.ui.layout.*
import androidx.ui.layout.RowScope.gravity
import androidx.ui.material.*
import androidx.ui.material.icons.Icons
import androidx.ui.material.icons.filled.*
import androidx.ui.tooling.preview.Preview
import androidx.ui.unit.dp
import com.dimension.mailwaycore.ui.MailWayTheme

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            Home()
        }

//        startActivity(
//            Intent(
//                this,
//                Class.forName("com.android.inputmethod.latin.setup.SetupActivity")
//            )
//        )
    }
}

@Preview(showBackground = true)
@Composable
fun Home() {
    val (drawerState, setDrawerState) = state {
        DrawerState.Closed
    }
    MailWayTheme {
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

@Preview(showBackground = true)
@Composable
fun buildHomeDrawer() {
    Column {
        VerticalScroller(
            modifier = Modifier.weight(1.0F)
        ) {
            Spacer(modifier = Modifier.preferredHeight(16.dp))
            buildDrawerMenu(icon = Icons.Default.AccountBox, title = "InBox")
            buildDrawerMenu(icon = Icons.Default.Email, title = "Drafts")
            buildDrawerMenu(icon = Icons.Default.AccountBox, title = "Contacts")
            buildDrawerMenu(icon = Icons.Default.Build, title = "Plugins")
        }

        buildDrawerMenu(icon = Icons.Default.Settings, title = "Settings")
        Spacer(modifier = Modifier.preferredHeight(16.dp))
    }
}


@Composable
fun buildDrawerMenu(
    icon: VectorAsset,
    title: String
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = {})
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