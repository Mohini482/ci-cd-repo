trigger primaryContactOnContactWithCheckbox on Contact (before insert,before update) {
list<contact> listContact = new list<contact>();
list<account> listAccount = new list<account>();
set<id> idSet = new Set<Id>();
String conId;
//if(Trigger.isInsert || Trigger.isUpdate) {
for(Contact contact:trigger.new)
{
  if(contact.primary__c==true)
  {
      idSet.add(contact.AccountId);
      conId= contact.Id;  
      listAccount.add(new account(id = contact.AccountId , primary_contact__c = contact.Id));
      
  }
}
//}

List<Contact> oldContactList = [select id, Primary__c from contact where accountid in:idSet AND Primary__c = true];

// Unchecking the Primary Contact Checkbox 
if(oldContactList.size()>0)
{
    for(Contact conNewList:oldContactList)
    {
       if(conNewList.Id != conId)
       {
         conNewList.primary__c=false;
         listContact.add(conNewList);
       
        

       }
    }
}
update listAccount;
update listContact;
}