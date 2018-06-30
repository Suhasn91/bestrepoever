public with sharing class AccountController
{   
    public class completeWrapper
    {
        @AuraEnabled    
        public Account accountRecord{get;set;}
        @AuraEnabled
        public List<contactWrapper> contactsList{get;set;}
    }
    
    public class contactWrapper
    {
        @AuraEnabled    
        public contact contactRecord{get;set;}
        @AuraEnabled
        public List<Contact_Email__c> mailObjectList{get;set;}
    }
    
    @AuraEnabled 
    public static String createRecords(String DataContent, String emailListIdsToDelete, String contactListIdsToDelete) 
    {
        //Email Delete
        List<String> emailIdsListToDelete = (List<String>)System.JSON.deserialize(emailListIdsToDelete, List<String>.class);
        List<Contact_Email__c> emailListToDelete = [select id from Contact_Email__c where Id In : emailIdsListToDelete];
        if(emailListToDelete.size() > 0)
            delete emailListToDelete;
        
        //Contact Delete
        List<String> contactIdsListToDelete = (List<String>)System.JSON.deserialize(contactListIdsToDelete, List<String>.class);
        List<Contact> contactListToDelete = [select id from Contact where Id In : contactIdsListToDelete];
        if(contactListToDelete.size() > 0)
            delete contactListToDelete;
            
        completeWrapper container = (completeWrapper)System.JSON.deserialize(DataContent, completeWrapper.class);
        System.debug('After DataContent----->'+container);
        
        //Account Data
        Account acc = new Account();
        acc = container.accountRecord;
        upsert acc;
        
        //Contact Data
        List<contact> contactRecordsToUpsert = new list<contact>();
        for(contactWrapper individualContactWrapper : container.contactsList)
        {
            contact con = new contact();
            con = individualContactWrapper.contactRecord;
            con.AccountId = acc.Id;
            contactRecordsToUpsert.add(con);
        }
        if(contactRecordsToUpsert.size() > 0)
            upsert contactRecordsToUpsert;
        
        Map<String, contact> employeeIdAndContactRecord = new Map<String, contact>();
        for(contact individualContact : contactRecordsToUpsert)
        {
            employeeIdAndContactRecord.put(individualContact.Employee_ID__c, individualContact);
        }
        
        //Email Data
        List<Contact_Email__c> contactEmailRecordsToUpsert = new list<Contact_Email__c>();
        for(contactWrapper individualContactWrapper : container.contactsList)
        {
            for(Contact_Email__c contactEmailRecord : individualContactWrapper.mailObjectList)
            {
                Contact_Email__c conEmail = new Contact_Email__c();
                conEmail = contactEmailRecord;
                if(conEmail.Id == null)
                    conEmail.Contact__c = employeeIdAndContactRecord.get(individualContactWrapper.contactRecord.Employee_ID__c).Id;
                contactEmailRecordsToUpsert.add(conEmail);
            }
        }
        if(contactEmailRecordsToUpsert.size() > 0)
            upsert contactEmailRecordsToUpsert;
        
        return acc.Id;
    }
    
    @AuraEnabled 
    public static completeWrapper getRecords(String accountRecordId) 
    {
        completeWrapper dataWrapper = new completeWrapper();
        List<contactWrapper> contactsRecordList = new List<contactWrapper>();
        Account acc = new Account();
        
        List<Contact> contactsExistingList = [select id, FirstName, LastName, Employee_ID__c, Phone, AccountId, Account.Name, Account.Phone, Account.NumberOfEmployees, Account.Description, Account.package_number__c, (select id, Contact__c, Email__c, Email_Type__c from Contact_Emails__r) from Contact where AccountId =: accountRecordId];
        integer count = 1;
        for(Contact con : contactsExistingList)
        {
            //Account Data
            if(count == 1)
            {
                acc.Name = con.Account.Name;
                acc.Phone = con.Account.Phone;
                acc.NumberOfEmployees = con.Account.NumberOfEmployees;
                acc.Description = con.Account.Description;
                acc.Id = con.AccountId;
                count++;
            }
            //contact Data
            contactWrapper conWrapper = new contactWrapper();
            Contact contactReferance = new Contact();
            contactReferance.FirstName = con.FirstName;
            contactReferance.LastName = con.LastName;
            contactReferance.Employee_ID__c = con.Employee_ID__c;
            contactReferance.Phone = con.Phone;
            contactReferance.Id = con.Id;
            conWrapper.contactRecord = contactReferance;
            //Email Data
            conWrapper.mailObjectList = con.Contact_Emails__r;
            contactsRecordList.add(conWrapper);
        }
        dataWrapper.accountRecord = acc;
        dataWrapper.contactsList = contactsRecordList;
        return dataWrapper;
    }
}