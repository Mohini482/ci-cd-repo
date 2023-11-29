trigger Task4 on Opportunity (after insert) 
{
    System.debug('Hello');
Set<Id> accountId = new Set<Id>();
set<Id> opportunityId = new Set<Id>();
System.debug('Hello');
List<Product2> listProduct = [select id,ProductCode from Product2 where(ProductCode='01' OR ProductCode='02')];
System.debug(listProduct);
Map<String,Id> mapProduct = new Map<String,Id>();
for(Product2 product2 : listproduct)
{
    mapProduct.put(product2.ProductCode, Product2.Id);
   // System.debug(mapProduct);
}
System.debug(mapProduct);

List<Opportunity> listOpportunity = new List<Opportunity>();
for(Opportunity opportunity :listOpportunity)
{
    accountId.add(opportunity.AccountId);
    OpportunityId.add(opportunity.Id);
}

List<PricebookEntry> listPriceBookEntry = new List<PricebookEntry>();



List<Pricebook2> listPricebook = [select id,name from Pricebook2];
System.debug(listPricebook);
Map<String,Id> mapPricebook = new Map<String,Id>();
for(Pricebook2 pricebook2 : listPricebook)
{
    mapPricebook.put(pricebook2.name, pricebook2.Id);
}
System.debug(mapPricebook);

if(trigger.isBefore)
{
    for(Opportunity opp : listOpportunity)
    {
       Account account =[select BillingCountry from account where id=:opp.accountId];
       if(account.BillingCountry == 'USA')
       {
          opp.Pricebook2Id = mapPriceBook.get('USA');
       }
       else if(account.BillingCountry == 'India')
       {
          opp.Pricebook2Id = mapPriceBook.get('India');   
       }
       else if(account.BillingCountry == 'Canada')
       {
          opp.Pricebook2Id = mapPriceBook.get('Canada');  
       }
       else if(account.BillingCountry== 'Australia')
       {
          opp.Pricebook2Id = mapPriceBook.get('Australia');  
       }
    
    }  
}


}