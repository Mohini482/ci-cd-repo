public with sharing class fetchContactRolesNewClass {
    public static void fetchContactRolesNewClass(List<OpportunityContactRole> contactRolesList) {
        Set<Id> setOpportunityId = new Set<Id>();
        Set<Id> setAccountId = new Set<Id>();
        List<Account> finalAccountList= new List<Account>();
        Integer count;
        for(OpportunityContactRole opportunityContactRole :contactRolesList)
        {
            setAccountId.add(opportunityContactRole.opportunity.accountId);
        }
        List<OpportunityContactRole> opportunityContactRoleList = [select id,opportunityid,contactid,opportunity.accountId,contact.name,role from OpportunityContactRole where id in : setAccountId and(role in ('Business Advisor','Technical Advisor'))];
        for(OpportunityContactRole oppContactRole : opportunityContactRoleList)
        {
            if(oppContactRole.Role=='Business Advisor')
            {
                Map<Id,Map<String,Integer>> mapOpportunityContactRoleWrapper = new Map<Id,map<String,Integer>>();

            if(mapOpportunityContactRoleWrapper.containsKey(oppContactRole.opportunity.accountId))
            { 
               Map<string,Integer> subMapOpportunityContactRoleWrapper = new Map<string,Integer>();

               Map<string,Integer> subMapOpportunityContactRole= mapOpportunityContactRoleWrapper.get(OppContactRole.opportunity.accountId); 
               if(subMapOpportunityContactRole.containsKey(oppContactRole.contact.name))
                
                {
                  count++;
                }
                else 
                {
                  
                 subMapOpportunityContactRoleWrapper.put(oppContactRole.contact.name,count);

                }
              mapOpportunityContactRoleWrapper.put(oppContactRole.opportunity.accountId,subMapOpportunityContactRoleWrapper);
            }
            
            else
             {
                mapOpportunityContactRoleWrapper.put(oppContactRole.opportunity.accountId,new Map<string,Integer>
                {
                    oppContactRole.contact.name =>(count)
                });
            }
        }
        
        update finalAccountList;
    }
    }}