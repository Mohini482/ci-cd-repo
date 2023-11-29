trigger toFetchContactRoles on OpportunityContactRole ( after update) {
//trigger toFetchContactRoles on OpportunityContactRole (before insert) {
 //List<OpportunityContactRole> oldContactRoleList = new List<OpportunityContactRole>();
        Set<Id> setOppId = new Set<Id>();
        Set<Id> setAccId = new Set<Id>();
        List<Account> finalAccountList= new List<Account>();
        Map<Id,Id>  idMap = new Map<Id,Id>();

        

        Map<id,Account>  accountMap = new Map<id,Account>([select Business_Advisor__c,Technical_Advisor__c from account]);
       // Map<id,contact> contactMap = new Map<id,Contact>();
       // Map<String,Contact> newMap = new Map<String,Contact>();
        String contactId,contactName;
        Integer businessCount=0,technicalCount=0;
        //map<id,Opportunity> opportunityMap = new map<id,Opportunity>();   
                    
        List<Opportunity> opportunityList = [select accountId from Opportunity];
        /*for(Account account : accList)
        {
          setAccId.add(account.Id);
        }*/
        for(Opportunity Opportunity : opportunityList)
        {
             setAccId.add(opportunity.AccountId);
            
        } 
    //system.debug(setAccId);
        
        List<Opportunity> secondOpportunityList = [ select accountId from Opportunity where id in : setAccId];
        /*for(OpportunityContactRole roleOfContacts :contactRoleList)
        {
          setOppId.add(oppContactRole.OpportunityId);
         
        }*/
        List<OpportunityContactRole> contactRoleList = [select id,opportunityid,contactid,opportunity.accountid,contact.name,role from opportunitycontactrole where opportunity.accountId in : setAccId];

        for(OpportunityContactRole opp:contactRoleList )
        {
            idMap.put(opp.id,opp.contactId );
        }
        list<account> acclist = new list<account>();
      //  List<OpportunityContactRole> contactRoleList = [select id,opportunityid,contactid,opportunity.accountid,contact.name,role from opportunitycontactrole where opportunity.accountId in : setAccId and(role ='Business Advisor' or role='Technical Advisor')];
        for(OpportunityContactRole oppContactRole : trigger.new)
        {
         setOppId.add(oppContactRole.OpportunityId);
         contactId= oppContactRole.contactId;
         contactName=oppContactRole.contact.name;
         for(Opportunity oppLoop : opportunityList)
         {

        
         
         //if(oppLoop.id==oppContactRole.opportunityid && oppContactRole.Role=='Business Advisor')
         if(oppContactRole.role=='Business Advisor')
         { 
             if(oppContactRole.contactId== idMap.get(oppContactRole.id))
             {
            
             businessCount++;
             string Business_Advisor =  oppContactRole.contact.name +'==>' + businessCount;
             accList.add(new Account(id = oppContactRole.opportunity.accountid,Business_Advisor__c = Business_Advisor));    
        
           }
           
        }
           
         
        
         else
          {
            //if(oppLoop.id==oppContactRole.opportunityid && oppContactRole.role=='Technical Advisor')
             if(oppContactRole.role=='Technical Advisor')
            {
              technicalCount++;
             String Technical_Advisor =  oppContactRole.contact.name +'==>' + technicalCount;
             accList.add(new Account(id = oppContactRole.opportunity.accountid,Technical_Advisor__c = Technical_Advisor));    


            } 
        
         }
        }
        
    }
    update acclist;
    
}