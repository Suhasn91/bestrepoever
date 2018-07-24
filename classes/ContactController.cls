public class ContactController 
{
    @AuraEnabled 
    public static String getEmail(String recordId)
    {
        List<Contact> contactList = [select id, Email from Contact where Id =: recordId];
        if(contactList.size() > 0)
            return contactList[0].Email;
        else
            return 'No Record';
    }
}