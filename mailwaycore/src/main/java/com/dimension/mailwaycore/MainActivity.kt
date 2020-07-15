package com.dimension.mailwaycore

import android.os.Bundle
import androidx.lifecycle.lifecycleScope
import com.dimension.mailwaycore.data.RoomDatabaseMethodCallHandler
import com.dimension.mailwaycore.ntge.NtgeMethodCallHandler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


//        startActivity(
//            Intent(
//                this,
//                Class.forName("com.android.inputmethod.latin.setup.SetupActivity")
//            )
//        )
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            RoomDatabaseMethodCallHandler.CHANNEL
        ).setMethodCallHandler(RoomDatabaseMethodCallHandler(lifecycleScope))
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            NtgeMethodCallHandler.CHANNEL
        ).setMethodCallHandler(NtgeMethodCallHandler(lifecycleScope, this))
    }
}


