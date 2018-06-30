public class ListViewController 
{
    @auraenabled
    public static accWrap fetchAccount(Integer limits , Integer offsets)
    {
        Integer intlimits = integer.valueof(limits);
        Integer intoffsets = integer.valueof(offsets);
        List<Account> accList = [select id,Name,Phone,Type,Industry from Account Order by createddate desc Limit :intlimits Offset :intoffsets];
        List<AggregateResult> result = [SELECT COUNT(Id) total FROM Account];
        integer rowscount = (Integer)result[0].get('total');
        return new accWrap(accList,rowscount);
    }
    
    @auraenabled
    public static conWrap fetchContact(Integer limits , Integer offsets)
    {
        Integer intlimits = integer.valueof(limits);
        Integer intoffsets = integer.valueof(offsets);
        List<Contact> conList = [select id,FirstName,LastName,Phone,Email from Contact Order by createddate desc Limit :intlimits Offset :intoffsets];
        List<AggregateResult> result = [SELECT COUNT(Id) total FROM Contact];
        integer rowscount = (Integer)result[0].get('total');
        return new conWrap(conList,rowscount);
    }
    
    public class accWrap
    {
        @auraenabled
        public List<Account> accList{get;set;}
        @auraenabled
        public integer totalRows{get;set;}
        
        public accWrap(List<Account> accList,integer totalRows)
        {
            this.accList = accList;
            this.totalRows = totalRows;
        }
    }
    
    public class conWrap
    {
        @auraenabled
        public List<Contact> conList{get;set;}
        @auraenabled
        public integer totalRows{get;set;}
        
        public conWrap(List<Contact> conList,integer totalRows)
        {
            this.conList = conList;
            this.totalRows = totalRows;
        }
    }
}