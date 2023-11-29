public with sharing class toFetchContactRoleInAccountclass
 {
    public static void toFetchContactRoleInAccountclass(List<OpportunityContactRole> contactRolesList) 
    {
        
        Set<Id> setOpportunityId = new Set<Id>();
        Set<Id> setAccountId = new Set<Id>();
        list<account> acclsttoupdate = new list<account>();
      
        for(OpportunityContactRole opportunityContactRole :contactRolesList)
        {
            setOpportunityId.add(opportunityContactRole.opportunityid);
        }

        list<Opportunity> listopp = [select accountid from Opportunity where id in :setOpportunityId];
        for (opportunity opp : listopp) 
        {
            setAccountId.add(opp.AccountId);
        }
      
      //  List<OpportunityContactRole> newOpportunityContactRoleList = new List<OpportunityContactRole>();
     //   Map<Id,Map<String,opportunityContactRoleWrapperClass>> mapOpportunityContactRoleWrapper = new Map<Id,map<String,opportunityContactRoleWrapperClass>>();
        Map<Id,list<opportunityContactRoleWrapperClass>> mapOpportunityContactRoleWrapper = new Map<Id,list<opportunityContactRoleWrapperClass>>();
          
        List<OpportunityContactRole> opportunityContactRoleList = [select id,opportunityid,contactid,opportunity.accountId,contact.name,role from OpportunityContactRole where opportunity.accountid in : setAccountId and(role in ('Business Advisor','Technical Advisor'))];
        //   System.debug(opportunityContactRoleList);
        for(OpportunityContactRole oppContactRole : opportunityContactRoleList)
        {
          if (oppContactRole.role=='Business Advisor') 
          {  
           if(mapOpportunityContactRoleWrapper.containsKey(oppContactRole.opportunity.accountId))
            {
                list<opportunityContactRoleWrapperClass> listWrapper= mapOpportunityContactRoleWrapper.get(oppContactRole.opportunity.accountId);
                // System.debug(listWrapper.indexOf('Mohini'));
                list<opportunityContactRoleWrapperClass> lst = new list<opportunityContactRoleWrapperClass>();
                for(opportunityContactRoleWrapperClass obj:listWrapper)
                {
                  if((string.valueOf(listWrapper)).contains(oppContactRole.contact.name))
                   {                            
                     if(obj.ContactName==oppContactRole.contact.name)
                     {
                       obj.Count++;
                       lst.add(obj);  
                     }
                     else 
                     {
                       lst.add(obj);
                     }
                   }
                    
                  else 
                  {
                     lst.add(obj);
                     lst.add(new opportunityContactRoleWrapperClass(oppContactRole.contact.Name));
                  }        
              }
                   // listWrapper.addAll(lst);
                   mapOpportunityContactRoleWrapper.put(oppContactRole.opportunity.accountId,lst);
          }
                //str = String.valueOf(listWrapper)
        }
            else
            {
               list<opportunityContactRoleWrapperClass> lst = new list<opportunityContactRoleWrapperClass>{new opportunityContactRoleWrapperClass(oppContactRole.contact.Name)};
               mapOpportunityContactRoleWrapper.put(oppContactRole.opportunity.accountId,lst);
            }    
        }      
            
  

         Map<Id,list<opportunityContactRoleWrapperClass>> mapOpportunityContactRoleWrapper1 = new Map<Id,list<opportunityContactRoleWrapperClass>>();
          
         List<OpportunityContactRole> opportunityContactRoleList1 = [select id,opportunityid,contactid,opportunity.accountId,contact.name,role from OpportunityContactRole where opportunity.accountid in : setAccountId and(role in ('Business Advisor','Technical Advisor'))];
         //   System.debug(opportunityContactRoleList);
         for(OpportunityContactRole oppContactRole : opportunityContactRoleList1)
         {
           if (oppContactRole.role=='Technical Advisor') 
           {  
            if(mapOpportunityContactRoleWrapper1.containsKey(oppContactRole.opportunity.accountId))
             {
                 list<opportunityContactRoleWrapperClass> listWrapper1= mapOpportunityContactRoleWrapper1.get(oppContactRole.opportunity.accountId);
                 // System.debug(listWrapper.indexOf('Mohini'));
                 list<opportunityContactRoleWrapperClass> lst1 = new list<opportunityContactRoleWrapperClass>();
                 for(opportunityContactRoleWrapperClass obj:listWrapper1)
                 {
                   if((string.valueOf(listWrapper1)).contains(oppContactRole.contact.name))
                    {                            
                      if(obj.ContactName==oppContactRole.contact.name)
                      {
                        obj.Count++;
                        lst1.add(obj);  
                      }
                      else 
                      {
                        lst1.add(obj);
                      }
                    }
                     
                   else 
                   {
                      lst1.add(obj);
                      lst1.add(new opportunityContactRoleWrapperClass(oppContactRole.contact.Name));
                   }        
               }
                    // listWrapper.addAll(lst);
                    mapOpportunityContactRoleWrapper1.put(oppContactRole.opportunity.accountId,lst1);
           }
                 //str = String.valueOf(listWrapper)
         }
             else
             {
                list<opportunityContactRoleWrapperClass> lst1 = new list<opportunityContactRoleWrapperClass>{new opportunityContactRoleWrapperClass(oppContactRole.contact.Name)};
                mapOpportunityContactRoleWrapper1.put(oppContactRole.opportunity.accountId,lst1);
             }    
         }      
          System.debug(mapOpportunityContactRoleWrapper1);    
   
        List<Account> finalAccountList= new List<Account>([select id,business_advisor__c, technical_advisor__c from account]);
        for(account acc : finalAccountList)
        {
          //if(mapOpportunityContactRoleWrapper.containsKey(acc.Id))
          String str = String.valueOf(mapOpportunityContactRoleWrapper.get(acc.id));
          String str1 = String.valueOf(mapOpportunityContactRoleWrapper1.get(acc.id));
          acclsttoupdate.add(new account(id = acc.Id ,  business_advisor__c = str));
          acclsttoupdate.add(new account(id = acc.Id ,  technical_advisor__c = str1));
        }

          update acclsttoupdate;  
    }
  
         
    
    // Wrapper Class :-

     public class opportunityContactRoleWrapperClass
     {
       public Integer Count;
       public String ContactName;
      //opportunityContactRoleWrapperClass oppWrapperClass;
       public opportunityContactRoleWrapperClass(String contactName)
       {
        //  AccountID=accountId;
        this.ContactName=contactName;
        this.count=1;
       } 
     }
 }