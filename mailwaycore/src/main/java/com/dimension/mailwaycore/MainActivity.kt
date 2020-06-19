package com.dimension.mailwaycore

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.Composable
import androidx.ui.core.setContent
import androidx.ui.foundation.Text
import androidx.ui.tooling.preview.Preview
import com.dimension.mailwaycore.ui.MailWayTheme

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            MailWayTheme {
                
            }
        }

        startActivity(Intent(this, Class.forName("com.android.inputmethod.latin.setup.SetupActivity")))
    }
}

@Composable
fun Greeting(name: String) {
    Text(text = "Hello $name!")
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    MailWayTheme {
        Greeting("Android")
    }
}