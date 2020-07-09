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

    @Query("SELECT * FROM chatmembernamestub")
    suspend fun getChatMemberNameStubs(): List<ChatMemberNameStub>

    @Query("SELECT * FROM chatmembernamestub WHERE key_id IN (:ids)")
    suspend fun getChatMemberNameStubsIn(ids: List<String>): List<ChatMemberNameStub>

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

    @Insert
    suspend fun insert(vararg chatAndChatMemberNameStubCrossRef: ChatAndChatMemberNameStubCrossRef)

    @Transaction
    @Query("""SELECT * FROM chat c 
        inner join chatandchatmembernamestubcrossref cref on cref.chatId = c.chatId 
        inner join chatmembernamestub cm on cm.chatMemberNameStubId = cref.chatMemberNameStubId 
        where c.identity_public_key = :senderId and cm.key_id in (:ids) group by c.chatId having count(*)=:length limit 1""")
    suspend fun getChatsWithChatMemberNameStubsIn(senderId: String, ids: List<String>, length: Int): ChatWithChatMemberNameStubs?

    @Transaction
    @Query("SELECT * FROM chat")
    suspend fun getChatWithChatMessagesWithChatMemberNameStubs(): List<ChatWithChatMessagesWithChatMemberNameStubs>
}
