package com.dimension.mailwaycore.data.dao

import androidx.lifecycle.LiveData
import androidx.room.*
import com.dimension.mailwaycore.data.entity.*

@Dao
interface ChatDao {

    @Query("SELECT * FROM chat")
    suspend fun getChats(): List<Chat>
    @Transaction
    @Query("SELECT * FROM chat")
    suspend fun getChatsWithChatMemberNameStubs(): List<ChatWithChatMemberNameStubs>
    @Transaction
    @Query("SELECT * FROM chat")
    suspend fun getChatWithChatMessages(): List<ChatWithChatMessages>
    @Transaction
    @Query("SELECT * FROM chatmembernamestub")
    suspend fun getChatMemberNameStubWithChats(): List<ChatMemberNameStubWithChats>

    @Query("SELECT * FROM chat")
    fun getChatsSync(): LiveData<List<Chat>>
    @Transaction
    @Query("SELECT * FROM chat")
    fun getChatsWithChatMemberNameStubsSync(): LiveData<List<ChatWithChatMemberNameStubs>>
    @Transaction
    @Query("SELECT * FROM chat")
    fun getChatWithChatMessagesSync(): LiveData<List<ChatWithChatMessages>>
    @Transaction
    @Query("SELECT * FROM chatmembernamestub")
    fun getChatMemberNameStubWithChatsSync(): LiveData<List<ChatMemberNameStubWithChats>>

    @Update
    suspend fun update(vararg chat: Chat)
    @Insert
    suspend fun insert(vararg chat: Chat)
    @Delete
    suspend fun delete(chat: Chat)

    @Update
    suspend fun update(vararg ChatMemberNameStub: ChatMemberNameStub)
    @Insert
    suspend fun insert(vararg ChatMemberNameStub: ChatMemberNameStub)
    @Delete
    suspend fun delete(ChatMemberNameStub: ChatMemberNameStub)

    @Update
    suspend fun update(vararg ChatMessage: ChatMessage)
    @Insert
    suspend fun insert(vararg ChatMessage: ChatMessage)
    @Delete
    suspend fun delete(ChatMessage: ChatMessage)
}
