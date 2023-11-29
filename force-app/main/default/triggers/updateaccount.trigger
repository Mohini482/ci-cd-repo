trigger updateaccount on Account (after update) {
 Set<id> AccountIds = new Set<id>();

for(Account a: trigger.new)

{

if(a.acities__c!= trigger.oldmap.get(a.id).acities__c){

AccountIds.add(a.id);

}

}

List<opportunity> opport=[select id, ocities__c,Accountid from Opportunity where accountid in: Accountids];

for(opportunity opp:opport)

{

opp.ocities__c = trigger.newmap.get(opp.accountid).acities__c;

}

update opport;

}