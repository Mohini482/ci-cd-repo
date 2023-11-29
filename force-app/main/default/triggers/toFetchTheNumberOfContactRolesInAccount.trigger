trigger toFetchTheNumberOfContactRolesInAccount on Opportunity (after update) {

  
//List<OpportunityContactRole> oldContactRoleList = new List<OpportunityContactRole>();
Set<Id> setOppId = new Set<Id>();
Set<Id> setAccId = new Set<Id>();
List<Account> finalAccountList= new List<Account>();
Map<id,Account>  accountMap = new Map<id,Account>();
Map<id,contact> contactMap = new Map<id,Contact>();
Map<String,Contact> newMap = new Map<String,Contact>();
String contactId,contactName;
Integer businessCount=0,technicalCount=0;
//map<id,Opportunity> opportunityMap = new map<id,Opportunity>();                 
List<Opportunity> opportunityList = [select accountId from Opportunity where id in :setOppId];
/*for(Account account : accList)
{
  setAccId.add(account.Id);
}*/
for(Opportunity Opportunity : trigger.new)
{
     setAccId.add(opportunity.AccountId);
}

/*for(OpportunityContactRole roleOfContacts :contactRoleList)
{
  setOppId.add(oppContactRole.OpportunityId);
 
}*/

//Account account =  new Account(id=account.Id, Business_Advisor__c ='',Technical_Advisor__c='');
list<account> acclist = new list<account>();
List<OpportunityContactRole> contactRoleList = [select id,opportunityid,contactid,opportunity.accountid,contact.name,role from opportunitycontactrole where opportunity.accountId in : setAccId and(role ='Business Advisor' or role='Technical Advisor')];
for(OpportunityContactRole oppContactRole : contactRoleList)
{
 setOppId.add(oppContactRole.OpportunityId);
 contactId= oppContactRole.contactId;
 contactName=oppContactRole.contact.name;

 if(oppContactRole.Role=='Business Advisor')
 //if(oppContactRole.role=='Business Advisor')
 {
   //if(oppContactRole.opportunity.accountid==accID)
   {
     businessCount++;
     string Business_Advisor =  oppContactRole.contact.name +'==>' + businessCount;
     accList.add(new Account(id = oppContactRole.opportunity.accountid,Business_Advisor__c = Business_Advisor));    

   }
   
   
 } 

 else
  {
    //if(oppContactRole.contains('Technical Advisor'))
    //{
     //  technicalCount++;
     // account.Technical_Advisor__c =  account.Technical_Advisor__c + account.contactName +'==>'+ account.contactId;
 //} 

 }
}






 

/*for(OpportunityContactRole opportunityContactRole : oldContactRoleList)
{
if(opportunityContactRole.Role == 'Business Advisor')
{
  if(opportunityContactRole.accountid==accId)
  {  
        countOfBusinessAdvisor++; 
        Business_Advisor= contactName + ':' + contactId;
  }
  else 
  { 
    if(opportunityContactRole.Role == 'Technical Advisor')

      if(opportunityContactRole.accountid==accId)
      {
        countOfTechnicalAdvisor++;
        Technical_Advisor = contactName + ':' + contactId;

      }
  }
}*/

}