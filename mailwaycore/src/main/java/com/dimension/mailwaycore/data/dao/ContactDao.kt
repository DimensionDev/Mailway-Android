package com.dimension.mailwaycore.data.dao

import androidx.lifecycle.LiveData
import androidx.room.*
import com.dimension.mailwaycore.data.entity.*

@Dao
interface ContactDao {

    @Transaction
    @Query("SELECT contact.*, keypair.id as keypair_id, keypair.contactId as keypair_contactId from contact join keypair on keypair.contactId = contact.id where keypair.private_key IS NOT NULL")
    suspend fun getContactsWithPrivateKey(): List<ContactAndKeyPairWithContactChannels>

    @Query("SELECT contact.*, keypair.id as keypair_id, keypair.contactId as keypair_contactId from contact join keypair on keypair.contactId = contact.id where keypair.private_key IS NULL")
    suspend fun getContactsWithoutPrivateKey(): List<ContactAndKeyPair>

    @Transaction
    @Query("SELECT * FROM contact where id = :id LIMIT 1")
    suspend fun queryContact(id: String): ContactAndKeyPairWithContactChannels

    @Query("SELECT contact.*, keypair.id as keypair_id, keypair.contactId as keypair_contactId from contact join keypair on keypair.contactId = contact.id where keypair.public_key = :publicKey LIMIT 1")
    suspend fun findContactWithPublicKey(publicKey: String): Contact?

    @Query("SELECT * FROM contact")
    suspend fun getContacts(): List<Contact>

    @Query("SELECT * FROM identitycard")
    suspend fun getIdentityCard(): List<IdentityCard>

    @Query("SELECT * FROM identitycard WHERE contactId = :id LIMIT 1")
    suspend fun getIdentityCardByContactId(id: String): IdentityCard?
    @Transaction
    @Query("SELECT * FROM contact")
    suspend fun getContactsAndKeyPairs(): List<ContactAndKeyPair>
    @Transaction
    @Query("SELECT contact.*, keypair.id as keypair_id, keypair.contactId as keypair_contactId from contact join keypair on keypair.contactId = contact.id where keypair.public_key in (:publicKeys)")
    suspend fun getContactsAndKeyPairsIn(publicKeys: List<String>): List<ContactAndKeyPair>
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
    suspend fun update(vararg identityCard: IdentityCard)

    @Update
    suspend fun update(vararg keypair: Keypair)

    @Update
    suspend fun update(vararg channel: ContactChannel)

    @Insert
    suspend fun insert(vararg contacts: Contact)

    @Insert
    suspend fun insert(vararg identityCard: IdentityCard)

    @Insert
    suspend fun insert(vararg keypair: Keypair)

    @Insert
    suspend fun insert(vararg channel: ContactChannel)

    @Delete
    suspend fun delete(contact: Contact)

    @Delete
    suspend fun delete(identityCard: IdentityCard)

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