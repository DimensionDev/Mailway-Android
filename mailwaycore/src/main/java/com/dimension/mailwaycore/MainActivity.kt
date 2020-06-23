package com.dimension.mailwaycore

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.Providers
import androidx.ui.core.setContent
import com.dimension.mailwaycore.data.AppDatabase
import com.dimension.mailwaycore.data.DatabaseAmbient
import com.dimension.mailwaycore.ui.MailwayApp
import org.koin.android.ext.android.inject

class MainActivity : AppCompatActivity() {
    private val database by inject<AppDatabase>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            Providers(
                DatabaseAmbient provides database
            ) {
                MailwayApp()
            }
        }

//        startActivity(
//            Intent(
//                this,
//                Class.forName("com.android.inputmethod.latin.setup.SetupActivity")
//            )
//        )
    }
}


