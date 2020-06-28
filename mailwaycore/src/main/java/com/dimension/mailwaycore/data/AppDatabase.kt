package com.dimension.mailwaycore.data

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.dimension.mailwaycore.data.dao.ChatDao
import com.dimension.mailwaycore.data.dao.ContactDao
import com.dimension.mailwaycore.data.entity.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

@Database(
    entities = [Contact::class, ContactChannel::class, Keypair::class, Chat::class, ChatMemberNameStub::class, ChatMessage::class, ChatAndChatMemberNameStubCrossRef::class, IdentityCard::class],
    version = 1
)
@TypeConverters(Converters::class)
abstract class AppDatabase : RoomDatabase() {
    abstract fun contactDao(): ContactDao

    abstract fun chatDao(): ChatDao
}


class RoomDatabaseMethodCallHandler : MethodChannel.MethodCallHandler {
    companion object {
        val CHANNEL = "com.dimension.mailwaycore/database"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

    }
}