trigger primaryContactOfAccountWithCheckboxTickInContact on Account (after update) {
 list<account> lstAccount = new list<account>();
 set<account>  setAccount = new set<account>();
 Map<id,Account> accMap = new Map<id,Account>();


 for(account ac : lstAccount)
 {
     setAccount.add(ac);
 }
    
 list<contact> lstContact = new list<contact>([select id,primary__c from contact where accountid=:setAccount]);
    for(account ac: setAccount)
    {
        
    }

    
    
}