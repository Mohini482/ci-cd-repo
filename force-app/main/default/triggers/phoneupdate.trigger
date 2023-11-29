trigger phoneupdate on Opportunity (after update) {

Set<id>accountIds = new set<id>();

List<contact> cc = new List<Contact>();

Map<Id, opportunity> accountidtoopp = new Map<Id, opportunity>();

if(trigger.new!=null)

{

for(opportunity opp:trigger.new)

if(opp.TestPhoneOpportunity__c != trigger.oldmap.get(opp.id).TestPhoneOpportunity__c)
{

accountIds.add(opp.AccountId);

accountidtoopp.put(opp.accountid,opp);

}

}

List<Account> acc = [Select id,TestPhoneAccount__c, (Select id,TestPhoneContact__c,AccountId from contacts )from Account where Id IN: accountIds ];

for(Account a:acc)

{

a.TestPhoneAccount__c = accountidtoopp.get(a.Id).TestPhoneOpportunity__c;

for(contact c: a.contacts)
{

c.TestPhoneContact__c = accountidtoopp.get(c.AccountId).TestPhoneOpportunity__c;

cc.add(c);

}

}

update acc;

update cc;
}