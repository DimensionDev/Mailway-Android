package com.dimension.mailwaycore.data.dao

import androidx.lifecycle.LiveData
import androidx.room.*
import com.dimension.mailwaycore.data.entity.*

@Dao
interface ContactDao {
    @Query("SELECT * FROM contact")
    suspend fun getContacts(): List<Contact>
    @Transaction
    @Query("SELECT * FROM contact")
    suspend fun getContactsAndKeyPairs(): List<ContactAndKeyPair>
    @Transaction
    @Query("SELECT * FROM contact")
    suspend fun getContactsWithChannels(): List<ContactWithChannels>

    @Query("SELECT * FROM contact")
    fun getContactsSync(): LiveData<List<Contact>>
    @Transaction
    @Query("SELECT * FROM contact")
    fun getContactsAndKeyPairsSync(): LiveData<List<ContactAndKeyPair>>
    @Transaction
    @Query("SELECT * FROM contact")
    fun getContactsWithChannelsSync(): LiveData<List<ContactWithChannels>>

    @Update
    suspend fun update(vararg contacts: Contact)

    @Update
    suspend fun update(vararg keypair: Keypair)

    @Update
    suspend fun update(vararg channel: ContactChannel)

    @Insert
    suspend fun insert(vararg contacts: Contact)

    @Insert
    suspend fun insert(vararg keypair: Keypair)

    @Insert
    suspend fun insert(vararg channel: ContactChannel)

    @Delete
    suspend fun delete(contact: Contact)

    @Delete
    suspend fun delete(keypair: Keypair)

    @Delete
    suspend fun delete(channel: ContactChannel)
}

suspend fun ContactDao.insert(contact: Contact, keypair: Keypair) {
    keypair.contactId = contact.id
    insert(keypair)
    insert(contact)
}

suspend fun ContactDao.insert(contact: Contact, vararg channel: ContactChannel) {
    channel.forEach { it.contactId = contact.id }
    insert(*channel)
}