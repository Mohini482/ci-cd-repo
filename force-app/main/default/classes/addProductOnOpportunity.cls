public with sharing class addProductOnOpportunity {
    public static void addProductOnOpportunity(List<Opportunity> listOpportunity) 
    {
    //     Set<Id> accountID = new Set<Id>();
    //     Set<Id> opportunityID = new Set<Id>();
           List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
           Map<Id,Account> mapAccount = new map<id,Account>([select id,BillingCountry,Account_Type__c from Account]);
           List<PricebookEntry> listPriceEntry = [select id,name,product2id,unitprice, pricebook2id,pricebook2.name,Product2.product_type__c from pricebookentry
           where Product2.product_type__c = 'Premium' or Product2.product_type__c = 'Regular'];
           
           System.debug(listPriceEntry);

           for(opportunity opportunity:listOpportunity )
           {
    //         accountID.add(opportunity.accountId);
    //         opportunityID.add(opportunity.id);
               if(Opportunity.accountId!=null)
               {
                   for(PricebookEntry priceEntry: listPriceEntry )
                   {
                       if(mapAccount.get(opportunity.accountId).BillingCountry==priceEntry.Pricebook2.Name && mapAccount.get(opportunity.accountId).Account_Type__c== priceEntry.Product2.product_Type__c)
                       {
                        opportunityLineItemList.add(new opportunityLineItem(priceBookEntryId= priceEntry.Id , opportunityId = opportunity.id,quantity = opportunity.contract_term__c,unitPrice= priceEntry.UnitPrice));
                       }
                   }
                }
                else 
                {
                    System.debug('Error!, You cannot add your products');
                } 
             }
               insert opportunityLineItemList;

               System.debug(opportunityLineItemList);
           }
        

    //     list<account> listAccount = [select id,Account_Type__c,BillingCountry from Account where id in :accountID];
        
    //     list<Pricebook2> listPriceBook = new List<Pricebook2>([select id,name from Pricebook2]);
    //     List<PricebookEntry> listPriceEntry = new List<PricebookEntry>();

    //     Map<Id,String> mapProduct = new Map<Id,String>();
    //     for(Product2 product : [select id,ProductCode from Product2 where(ProductCode='01' OR ProductCode='02')])
    //     {
    //         mapProduct.put(product.Id,product.ProductCode);
    //     }
        
    //     Map<Id,String> mapPriceBook = new Map<Id,String>();
    //     for(PriceBook2 priceBook2 : listPriceBook )
    //     {
    //         mapPriceBook.put(priceBook2.id,priceBook2.name);
    //     }
        
    //     if(trigger.isbefore)
    //     {
    //       for(Opportunity opportunity :listOpportunity)
    //        {
    //         Account account =[select BillingCountry from account where id=:accountID];
    //         if(account.BillingCountry=='India')
    //         {
                
    //         }
    //         else if(account.BillingCountry=='Canada')
    //         {
                
    //         }
    //         else if(account.BillingCountry=='Australia')
    //         {
               
    //         }
    //         else if(account.BillingCountry=='USA')
    //         {
                
    //         }
    //     }


    //     if(Trigger.isAfter)
    //     {
       
    //      for(Account account : listAccount)
    //      {
    //          if(account.Account_Type__c=='Regular')
    //          {
    //            if(account.BillingCountry=='India')
    //            {
    //             listPriceEntry = [select id,UnitPrice from PricebookEntry where Product2Id=:mapProduct.get('01')];
    //            }
    //            else if(account.BillingCountry=='Canada')
    //            {
    //             listPriceEntry = [select id,UnitPrice from PricebookEntry where Product2Id=:mapProduct.get('02')];
    //            }
    //            else if(account.BillingCountry=='USA')
    //            {
    //             listPriceEntry = [select id,UnitPrice from PricebookEntry where Product2Id=:mapProduct.get('03')];
    //            }
    //            else if(account.BillingCountry=='Australia')
    //            {
    //             listPriceEntry = [select id,UnitPrice from PricebookEntry where Product2Id=:mapProduct.get('04')];
    //            }
    //          }
    //         // OpportunityLineItem[] lines = new OpportunityLineItem[0];
    //         list<opportunityLineItem> addProductToOpportunity = new list<opportunityLineItem>();
                        
    //         for(opportunity Record:listOpportunity){
                
    //             addProductToOpportunity.add(new OpportunityLineItem(Product2Id = mapProduct.get('01'), OpportunityId = Record.id, UnitPrice=listPriceEntry[0].UnitPrice,Quantity=2));
    //             system.debug( addProductToOpportunity);
    //         }
    //           insert  addProductToOpportunity;
    //      }
       
        

        
        
        

        
    //     }
   // }
    public static void insertRevenueGenerate(list<Opportunity> newListRevenue)
    {
        list<Opportunity> newListOpportunity = [select id,Contract_Term__c,Revenue_Generate__c,Amount,createdDate from opportunity where id in :newListRevenue];

        list<Revenue_Generate__c> listRevenueGenerate = new list<Revenue_Generate__c>();
        for(Opportunity newOpportunity: newListOpportunity)
        {
            if(newOpportunity.Revenue_Generate__c=='monthly')
            {
               double amount = newOpportunity.Amount/newOpportunity.Contract_Term__c;
               for(Integer i=1;i<=newOpportunity.Contract_Term__c;i++)
               {
                   date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                   listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
               }
            }
            else if(newOpportunity.Revenue_Generate__c=='quarterly')
            {
                if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 3)==0)
                {
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*3;
                    for(Integer i=3;i<=newOpportunity.Contract_Term__c;i+=3)
                    {
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                }
               else  if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 3)!=0)
               {
                   Integer fetchRemainder = Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 3);
                   for(Integer i=3;i<=newOpportunity.Contract_Term__c;i+=3)
                    {
                      double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*3;
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*fetchRemainder;
                    date closeDate = newOpportunity.CreatedDate.date().addMonths(integer.valueOf(newOpportunity.Contract_Term__c)).toStartofMonth().addDays(-1);
                    listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));

               }
                
            }
            else if(newOpportunity.Revenue_Generate__c=='half yearly')
            {
                if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 6)==0)
                {
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*6;
                    for(Integer i=6;i<=newOpportunity.Contract_Term__c;i+=6)
                    {
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                }
               else  if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 6)!=0)
               {
                   Integer fetchRemainder = Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 6);
                   for(Integer i=6;i<=newOpportunity.Contract_Term__c;i+=6)
                    {
                      double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*6;
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*fetchRemainder;
                    date closeDate = newOpportunity.CreatedDate.date().addMonths(integer.valueOf(newOpportunity.Contract_Term__c)).toStartofMonth().addDays(-1);
                    listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));

               }
                
            }   
            
            else if(newOpportunity.Revenue_Generate__c=='yearly')
            {
                if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 12)==0)
                {
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*12;
                    for(Integer i=12;i<=newOpportunity.Contract_Term__c;i+=12)
                    {
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                }
               else  if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 12)!=0)
               {
                   Integer fetchRemainder = Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 12);
                   for(Integer i=12;i<=newOpportunity.Contract_Term__c;i+=12)
                    {
                      double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*12;
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*fetchRemainder;
                    date closeDate = newOpportunity.CreatedDate.date().addMonths(integer.valueOf(newOpportunity.Contract_Term__c)).toStartofMonth().addDays(-1);
                    listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));

               }
                
            }
            }
            insert listRevenueGenerate;
        }
   
    public static void updateRevenueGenerate(list<Opportunity> updateNewListRevenue)
    {
        list<Opportunity> newListRevenue = [select id,Contract_Term__c,Revenue_Generate__c,Amount,createdDate from opportunity where id in :updateNewListRevenue];
        list<Revenue_Generate__c> newListRevenueGenerate = new list<Revenue_Generate__c>([select id,Opportunity_Id__c from Revenue_Generate__c where Opportunity_Id__c in :updateNewListRevenue]);

        list<Revenue_Generate__c> listRevenueGenerate = new list<Revenue_Generate__c>();
        for(Opportunity newOpportunity: newListRevenue)
        {
            if(newOpportunity.Revenue_Generate__c=='monthly')
            {
               double amount = newOpportunity.Amount/newOpportunity.Contract_Term__c;
               for(Integer i=1;i<=newOpportunity.Contract_Term__c;i++)
               {
                   date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                   listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
               }
            }
            else if(newOpportunity.Revenue_Generate__c=='quarterly')
            {
                if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 3)==0)
                {
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*3;
                    for(Integer i=3;i<=newOpportunity.Contract_Term__c;i+=3)
                    {
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                }
               else  if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 3)!=0)
               {
                   Integer fetchRemainder = Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 3);
                   for(Integer i=3;i<=newOpportunity.Contract_Term__c;i+=3)
                    {
                      double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*3;
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*fetchRemainder;
                    date closeDate = newOpportunity.CreatedDate.date().addMonths(integer.valueOf(newOpportunity.Contract_Term__c)).toStartofMonth().addDays(-1);
                    listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));

               }
                
            }
            else if(newOpportunity.Revenue_Generate__c=='half yearly')
            {
                if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 6)==0)
                {
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*6;
                    for(Integer i=6;i<=newOpportunity.Contract_Term__c;i+=6)
                    {
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                }
               else  if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 6)!=0)
               {
                   Integer fetchRemainder = Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 6);
                   for(Integer i=6;i<=newOpportunity.Contract_Term__c;i+=6)
                    {
                      double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*6;
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*fetchRemainder;
                    date closeDate = newOpportunity.CreatedDate.date().addMonths(integer.valueOf(newOpportunity.Contract_Term__c)).toStartofMonth().addDays(-1);
                    listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));

               }
                
            }   
            
            else if(newOpportunity.Revenue_Generate__c=='yearly')
            {
                if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 12)==0)
                {
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*12;
                    for(Integer i=12;i<=newOpportunity.Contract_Term__c;i+=12)
                    {
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                }
               else  if(Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 12)!=0)
               {
                   Integer fetchRemainder = Math.mod(integer.valueOf(newOpportunity.Contract_Term__c), 12);
                   for(Integer i=12;i<=newOpportunity.Contract_Term__c;i+=12)
                    {
                      double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*12;
                      date closeDate = newOpportunity.CreatedDate.date().addMonths(i).toStartofMonth().addDays(-1);
                      listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));
                    }
                    double amount = (newOpportunity.Amount/newOpportunity.Contract_Term__c)*fetchRemainder;
                    date closeDate = newOpportunity.CreatedDate.date().addMonths(integer.valueOf(newOpportunity.Contract_Term__c)).toStartofMonth().addDays(-1);
                    listRevenueGenerate.add(new Revenue_Generate__c (Opportunity_Id__c= newOpportunity.id,Expected_Amount__c=amount ,Close_Date__c=closeDate));

               }
                
            }
            }
            delete newListRevenueGenerate ;
            insert listRevenueGenerate ;
   
   
   
   
    }
}