package com.dimension.mailwaycore.data

import com.dimension.mailwaycore.data.entity.*
import com.dimension.mailwaycore.utils.JSON
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.serialization.builtins.list
import org.koin.java.KoinJavaComponent

class RoomDatabaseMethodCallHandler(private val scope: CoroutineScope) :
    MethodChannel.MethodCallHandler {

    val database by KoinJavaComponent.inject(AppDatabase::class.java)

    companion object {
        val CHANNEL = "com.dimension.mailwaycore/database"
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val table = call.argument<String>("table") ?: kotlin.run {
            result.error("01", "argument exception", null)
            return
        }
        when (call.method) {
            "getContactsWithPrivateKey" -> {
                scope.launch {
                    database.contactDao().getContactsWithPrivateKey().let {
                        JSON.stringify(ContactAndKeyPair.serializer().list, it)
                    }.let {
                        result.success(it)
                    }
                }
            }
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
                        else -> {
                            result.error("02", "argument out of range exception", null)
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
                    result.error("01", "argument exception", null)
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
                        else -> {
                            result.error("02", "argument out of range exception", null)
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
                            result.error("02", "argument out of range exception", null)
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
                            result.error("02", "argument out of range exception", null)
                        }
                    }
                }
            }
        }
    }
}