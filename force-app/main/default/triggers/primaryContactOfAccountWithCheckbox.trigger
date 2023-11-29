trigger primaryContactOfAccountWithCheckbox on Account (after update) {
   /* trigger primaryContactOfAccountWithCheckbox on Account (after insert) {
        public void primaryContactMethod()
        {
            list<account> accList = [select id,name,Primary_Contact__c from account];
            list<contact> conList = [select id,name,Primary__c from contact];
            for(account a : accList)
            {
                accList.contains(a);
                
                
            }*/
            list<Contact> contactList = new list<Contact>();
            for(Account account: trigger.new)
            {
            if(account.primary_contact__c != trigger.oldMap.get(account.id).primary_contact__c)
               {
              contactList.add(new Contact(id=account.primary_contact__c,primary__c=true) );    
            }
          
           if(trigger.oldMap.get(account.id).primary_contact__c!=null)
            {
                contactList.add(new Contact(id=trigger.oldMap.get(account.id).primary_contact__c,primary__c=false) );    

            }
          }
              
          update contactList;  
        }