package com.dimension.mailwaycore.ui.scene

import androidx.compose.Composable
import androidx.compose.state
import androidx.ui.core.Alignment
import androidx.ui.core.ContentScale
import androidx.ui.core.Modifier
import androidx.ui.core.clip
import androidx.ui.foundation.*
import androidx.ui.foundation.shape.corner.RoundedCornerShape
import androidx.ui.graphics.Color
import androidx.ui.layout.*
import androidx.ui.material.*
import androidx.ui.material.icons.Icons
import androidx.ui.material.icons.filled.AccountCircle
import androidx.ui.material.icons.filled.Check
import androidx.ui.material.icons.filled.Close
import androidx.ui.material.icons.filled.Done
import androidx.ui.tooling.preview.Preview
import androidx.ui.unit.dp
import com.dimension.mailwaycore.data.DatabaseAmbient
import com.dimension.mailwaycore.ui.Screen
import com.dimension.mailwaycore.ui.navigateTo

@Preview
@Composable
fun AddContact() {
    val database = DatabaseAmbient.current
    val (name, setName) = state { "" }
    val (pubKey, setPubKey) = state { "" }


    Scaffold(
        topAppBar = {
            TopAppBar(
                elevation = 0.dp,
                backgroundColor = MaterialTheme.colors.background,
                title = {
                },
                actions = {
                    IconButton(onClick = {}) {
                        Icon(asset = Icons.Default.Done)
                    }
                },
                navigationIcon = {
                    IconButton(onClick = {
                        navigateTo(Screen.Contacts)
                    }) {
                        Icon(asset = Icons.Default.Close)
                    }
                })
        }
    ) {
        VerticalScroller(
            modifier = Modifier.fillMaxWidth()
        ) {
            Stack(
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier
                        .gravity(Alignment.BottomCenter)
                ) {
                    Image(
                        modifier = Modifier
                            .width(100.dp)
                            .aspectRatio(1.0F),
                        asset = Icons.Default.AccountCircle,
                        contentScale = ContentScale.Fit
                    )
                    Spacer(modifier = Modifier.height(6.dp))
                }

                Surface(
                    modifier = Modifier
                        .padding(4.dp)
                        .gravity(Alignment.BottomCenter)
                        .clip(RoundedCornerShape(100.dp)),
                    color = MaterialTheme.colors.primary,
                    contentColor = MaterialTheme.colors.onPrimary
                ) {
                    Image(
                        asset = Icons.Default.Check
                    )
                }

            }
            Surface(border = Border(Color.Gray, 1.dp), modifier = Spacing(8.dp)) {
                TextField(value = TextFieldValue(name), onValueChange = {
                    setName(it.text)
                })
            }

            TextField(value = TextFieldValue(pubKey), onValueChange = {
                setPubKey(it.text)
            })
        }
    }
}