public with sharing class accountTriggerHandler {
    
    public static boolean recursionAcc=false;
    public static void accountMethod(list<account> listAccount,Map<id,account> mapAccount)
    {
        list<Contact> contactList = new list<Contact>();
        for(Account account: listAccount)
        {
          if(account.primary_contact__c !=mapAccount.get(account.id).primary_contact__c)
            {
              contactList.add(new Contact(id=account.primary_contact__c,primary__c=true));    
            }
          
          if(mapAccount.get(account.id).primary_contact__c!=null)
            {
              contactList.add(new Contact(id=mapAccount.get(account.id).primary_contact__c,primary__c=false) );   
            }
        }
              
          update contactList;  
    }
}