public with sharing class Task4 {
    public static void Task4(list<Opportunity> lstnewOpportunity) {
        list<PricebookEntry> lstPriceBook = new list<PricebookEntry>();
        
        //all products with their ProductCodes and ID's
        Map<String,String> mapAllProduct = new Map<String,String>();
        for(Product2 pro : [SELECT id,ProductCode FROM Product2 WHERE (ProductCode='01' OR ProductCode='02')])
        {
            mapAllProduct.put(pro.ProductCode, pro.Id);
        }
        
        Map<string,string> mapPriceBook = new Map<String,String>();
        for(Pricebook2 pricebook : [SELECT id, name FROM Pricebook2] )
        {
            mapPriceBook.put(pricebook.name,pricebook.id);
        }
        
        
        if(trigger.isbefore){
            
            for(Opportunity record :  lstnewOpportunity){
                Account acc = [SELECT BillingCountry FROM Account WHERE id=:record.AccountId];
                if(acc.BillingCountry == 'U.S'){
                    record.Pricebook2Id = mapPriceBook.get('USA');
                }
                else if(acc.BillingCountry == 'India'){
                    record.Pricebook2Id = mapPriceBook.get('India');   
                }
                else if(acc.BillingCountry == 'Canada'){
                    record.Pricebook2Id = mapPriceBook.get('Canada');  
                }
                else if(acc.BillingCountry== 'Australia'){
                    record.Pricebook2Id = mapPriceBook.get('Australia');  
                }
                
                system.debug('Price book set to Opp'+  record.Pricebook2Id);
                
            }
        }
        
        if(trigger.isinsert){
            
            if(trigger.isafter){
                
                set<id> accountID = new set<ID>();
                set<id> opportunityID = new set<ID>();
                
                for(opportunity opp:  lstnewOpportunity ){
                    
                    accountID.add(opp.accountID);
                    opportunityID.add(opp.id);
                }
                
                list<account> lstNewAccount = [SELECT id,Account_Type__c,BillingCountry From Account WHERE id IN : accountID];
                system.debug('account list'+lstNewAccount);
                
                //map for priceBook
                Map<string,string> mapPricebookNameToId = new map<string,string>();
                for(Pricebook2 objBook : [SELECT Name , Id FROM Pricebook2 ]){
                    mapPricebookNameToId.put(objBook.Name,objBook.Id);
                }
                
                for(account objAccount : lstNewAccount){
                    
                    if(objAccount.Account_Type__c == 'Regular'){
                        
                        
                        if(objAccount.BillingCountry=='India')
                        {
                            //new
                            lstPriceBook = [SELECT id, UnitPrice FROM PricebookEntry WHERE Product2Id =: mapAllProduct.get('01') AND Pricebook2Id =: mapPricebookNameToId.get('India')];          
                        }   
                        else if(objAccount.BillingCountry=='USA')
                        {
                            //List<Pricebook2> entry = [SELECT Id FROM Pricebook2 
                            //WHERE Name =  'U.S'];
                            lstPriceBook = [SELECT id, UnitPrice FROM PricebookEntry WHERE Product2Id =:mapAllProduct.get('01') AND Pricebook2Id =: mapPricebookNameToId.get('U.S')];  
                            system.debug(lstPriceBook);     
                        }
                        
                        else if(objAccount.BillingCountry=='Canada')
                        {
                            //List<Pricebook2> entry = [SELECT Id FROM Pricebook2 
                            //WHERE Name =  'Canada'];
                            lstPriceBook = [SELECT id, UnitPrice FROM PricebookEntry WHERE Product2Id =:mapAllProduct.get('01') AND Pricebook2Id =: mapPricebookNameToId.get('Canda')];  
                            system.debug(lstPriceBook);     
                        }
                        else if(objAccount.BillingCountry=='Australia')
                        {
                            // List<Pricebook2> entry = [SELECT Id FROM Pricebook2 
                            //WHERE Name =  'Australia'];
                            lstPriceBook = [SELECT id, UnitPrice FROM PricebookEntry WHERE Product2Id =:mapAllProduct.get('01') AND Pricebook2Id =:mapPricebookNameToId.get('Australia')];  
                            system.debug(lstPriceBook);     
                        }
                        list<opportunityLineItem> addProductToOpportunity = new list<opportunityLineItem>();
                        
                        for(opportunity oppRecord :  lstnewOpportunity){
                            
                            addProductToOpportunity.add(new OpportunityLineItem(Product2Id = mapAllProduct.get('01'), OpportunityId = oppRecord.id, UnitPrice=lstPriceBook[0].UnitPrice,Quantity=2));
                            system.debug( addProductToOpportunity);
                        }
                        
                        
                        insert  addProductToOpportunity;
                        system.debug('Opportunity after insert : '+lstnewOpportunity[0].amount);
                    }
                    
                    
                    
                }
            }
        }
    }
    }