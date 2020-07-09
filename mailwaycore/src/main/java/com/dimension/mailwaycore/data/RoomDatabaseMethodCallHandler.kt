package com.dimension.mailwaycore.data

import android.util.Log
import com.dimension.mailwaycore.data.entity.*
import com.dimension.mailwaycore.utils.JSON
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlinx.serialization.builtins.list
import kotlinx.serialization.builtins.serializer
import org.koin.java.KoinJavaComponent

class RoomDatabaseMethodCallHandler(private val scope: CoroutineScope) :
    MethodChannel.MethodCallHandler {

    val database by KoinJavaComponent.inject(AppDatabase::class.java)

    companion object {
        val CHANNEL = "com.dimension.mailwaycore/database"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "getContactsWithPrivateKey") {
            scope.launch {
                database.contactDao().getContactsWithPrivateKey().let {
                    JSON.stringify(ContactAndKeyPairWithContactChannels.serializer().list, it)
                }.let {
                    result.success(it)
                }
            }
            return
        }

        if (call.method == "queryContact") {
            val contactId = call.argument<String>("contactId") ?: run {
                result.error("01", "argument exception", "require contactId")
                return
            }
            scope.launch {
                database.contactDao().queryContact(contactId).let {
                    JSON.stringify(ContactAndKeyPairWithContactChannels.serializer(), it)
                }.let {
                    result.success(it)
                }
            }
            return
        }

        if (call.method == "getContactsAndKeyPairsIn") {
            val contactIds = call.argument<String>("ids")?.let {
                JSON.parse(String.serializer().list, it)
            } ?: run {
                result.error("01", "argument exception", "require contact Ids")
                return
            }
            scope.launch {
                result.success(database.contactDao().getContactsAndKeyPairsIn(contactIds).let {
                    JSON.stringify(ContactAndKeyPair.serializer().list, it)
                })
            }
            return
        }
        if (call.method == "getChatMemberNameStubsIn") {
            val keyids = call.argument<String>("ids")?.let {
                JSON.parse(String.serializer().list, it)
            } ?: run {
                result.error("01", "argument exception", "require contactId")
                return
            }
            scope.launch {
                result.success(database.chatDao().getChatMemberNameStubsIn(keyids).let {
                    JSON.stringify(ChatMemberNameStub.serializer().list, it)
                })
            }
            return
        }

        if (call.method == "getChatsWithChatMemberNameStubsIn") {
            val contactIds = call.argument<String>("ids")?.let {
                JSON.parse(String.serializer().list, it)
            } ?: run {
                result.error("01", "argument exception", "require contact Ids")
                return
            }
            val sender = call.argument<String>("sender") ?: kotlin.run {
                result.error("01", "argument exception", "require sender")
                return
            }
            scope.launch {
                val chat = database.chatDao().getChatsWithChatMemberNameStubsIn(senderId = sender, ids = contactIds, length = contactIds.size)
                Log.i("chat", chat?.let {
                    JSON.stringify(ChatWithChatMemberNameStubs.serializer(), it) } ?: "null")
                result.success(chat?.let {
                    JSON.stringify(ChatWithChatMemberNameStubs.serializer(), it)
                })
            }
            return
        }

        val table = call.argument<String>("table") ?: kotlin.run {
            result.error("01", "argument exception", "require table name")
            return
        }
        
        when (call.method) {
            "query" -> {
                scope.launch {
                    val data = when (table) {
                        "Chats" -> database.chatDao().getChats().let {
                            JSON.stringify(Chat.serializer().list, it)
                        }
                        "ChatWithChatMemberNameStubs" -> database.chatDao()
                            .getChatsWithChatMemberNameStubs().let {
                            JSON.stringify(ChatWithChatMemberNameStubs.serializer().list, it)
                        }
                        "ChatWithChatMessages" -> database.chatDao().getChatWithChatMessages().let {
                            JSON.stringify(ChatWithChatMessages.serializer().list, it)
                        }
                        "ChatMemberNameStubWithChats" -> database.chatDao()
                            .getChatMemberNameStubWithChats().let {
                            JSON.stringify(ChatMemberNameStubWithChats.serializer().list, it)
                        }
                        "Contact" -> database.contactDao().getContacts().let {
                            JSON.stringify(Contact.serializer().list, it)
                        }
                        "ContactAndKeyPair" -> database.contactDao().getContactsAndKeyPairs().let {
                            JSON.stringify(ContactAndKeyPair.serializer().list, it)
                        }
                        "ContactWithChannels" -> database.contactDao().getContactsWithChannels()
                            .let {
                                JSON.stringify(ContactWithChannels.serializer().list, it)
                            }
                        "IdentityCard" -> database.contactDao().getIdentityCard()
                            .let {
                                JSON.stringify(IdentityCard.serializer().list, it)
                            }
                        "ChatWithChatMessagesWithChatMemberNameStubs" -> database.chatDao().getChatWithChatMessagesWithChatMemberNameStubs().let {
                            JSON.stringify(ChatWithChatMessagesWithChatMemberNameStubs.serializer().list, it)
                        }
                        else -> {
                            result.error("02", "argument out of range exception", "unknown table name $table")
                            null
                        }
                    }
                    if (data != null) {
                        result.success(data)
                    }
                }
            }
            "insert" -> {
                val json = call.argument<String>("data") ?: kotlin.run {
                    result.error("01", "argument exception", "require insert data")
                    return
                }
                scope.launch {
                    when (table) {
                        "Chats" -> {
                            JSON.parse(Chat.serializer(), json).let {
                                database.chatDao().insert(it)
                                result.success(true)
                            }
                        }
                        "ChatMemberNameStub" -> {
                            JSON.parse(ChatMemberNameStub.serializer(), json).let {
                                database.chatDao().insert(it)
                                result.success(true)
                            }
                        }
                        "ChatMessage" -> {
                            JSON.parse(ChatMessage.serializer(), json).let {
                                database.chatDao().insert(it)
                                result.success(true)
                            }
                        }
                        "Contact" -> {
                            JSON.parse(Contact.serializer(), json).let {
                                database.contactDao().insert(it)
                                result.success(true)
                            }
                        }
                        "Keypair" -> {
                            JSON.parse(Keypair.serializer(), json).let {
                                database.contactDao().insert(it)
                                result.success(true)
                            }
                        }
                        "ContactChannel" -> {
                            JSON.parse(ContactChannel.serializer(), json).let {
                                database.contactDao().insert(it)
                                result.success(true)
                            }
                        }
                        "IdentityCard" -> {
                            JSON.parse(IdentityCard.serializer(), json).let {
                                database.contactDao().insert(it)
                                result.success(true)
                            }
                        }
                        "ChatAndChatMemberNameStubCrossRef" -> {
                            JSON.parse(ChatAndChatMemberNameStubCrossRef.serializer(), json).let {
                                database.chatDao().insert(it)
                                result.success(true)
                            }
                        }
                        else -> {
                            result.error("02", "argument out of range exception", "unknown table name $table")
                        }
                    }
                }
            }
            "update" -> {
                val json = call.argument<String>("data") ?: kotlin.run {
                    result.error("01", "argument exception", null)
                    return
                }
                scope.launch {
                    when (table) {
                        "Chats" -> {
                            JSON.parse(Chat.serializer(), json).let {
                                database.chatDao().update(it)
                                result.success(true)
                            }
                        }
                        "ChatMemberNameStub" -> {
                            JSON.parse(ChatMemberNameStub.serializer(), json).let {
                                database.chatDao().update(it)
                                result.success(true)
                            }
                        }
                        "ChatMessage" -> {
                            JSON.parse(ChatMessage.serializer(), json).let {
                                database.chatDao().update(it)
                                result.success(true)
                            }
                        }
                        "Contact" -> {
                            JSON.parse(Contact.serializer(), json).let {
                                database.contactDao().update(it)
                                result.success(true)
                            }
                        }
                        "Keypair" -> {
                            JSON.parse(Keypair.serializer(), json).let {
                                database.contactDao().update(it)
                                result.success(true)
                            }
                        }
                        "ContactChannel" -> {
                            JSON.parse(ContactChannel.serializer(), json).let {
                                database.contactDao().update(it)
                                result.success(true)
                            }
                        }
                        "IdentityCard" -> {
                            JSON.parse(IdentityCard.serializer(), json).let {
                                database.contactDao().update(it)
                                result.success(true)
                            }
                        }
                        else -> {
                            result.error("02", "argument out of range exception", "unknown table name $table")
                        }
                    }
                }
            }
            "delete" -> {
                val json = call.argument<String>("data") ?: kotlin.run {
                    result.error("01", "argument exception", null)
                    return
                }
                scope.launch {
                    when (table) {
                        "Chats" -> {
                            JSON.parse(Chat.serializer(), json).let {
                                database.chatDao().delete(it)
                                result.success(true)
                            }
                        }
                        "ChatMemberNameStub" -> {
                            JSON.parse(ChatMemberNameStub.serializer(), json).let {
                                database.chatDao().delete(it)
                                result.success(true)
                            }
                        }
                        "ChatMessage" -> {
                            JSON.parse(ChatMessage.serializer(), json).let {
                                database.chatDao().delete(it)
                                result.success(true)
                            }
                        }
                        "Contact" -> {
                            JSON.parse(Contact.serializer(), json).let {
                                database.contactDao().delete(it)
                                result.success(true)
                            }
                        }
                        "Keypair" -> {
                            JSON.parse(Keypair.serializer(), json).let {
                                database.contactDao().delete(it)
                                result.success(true)
                            }
                        }
                        "ContactChannel" -> {
                            JSON.parse(ContactChannel.serializer(), json).let {
                                database.contactDao().delete(it)
                                result.success(true)
                            }
                        }
                        "IdentityCard" -> {
                            JSON.parse(IdentityCard.serializer(), json).let {
                                database.contactDao().delete(it)
                                result.success(true)
                            }
                        }
                        else -> {
                            result.error("02", "argument out of range exception", "unknown table name $table")
                        }
                    }
                }
            }
        }
    }
}