package com.dimension.mailwaycore

import android.app.Application
import androidx.room.Room
import com.dimension.mailwaycore.data.AppDatabase
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin
import org.koin.dsl.module

class App: Application() {

    private val appModule = module {
        single {
            Room.databaseBuilder(
                applicationContext,
                AppDatabase::class.java, "app-db"
            ).build()
        }
    }

    override fun onCreate() {
        super.onCreate()
        startKoin{
            androidLogger()
            androidContext(this@App)
            modules(appModule)
        }
    }
}
