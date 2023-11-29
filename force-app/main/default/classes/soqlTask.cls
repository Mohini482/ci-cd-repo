public class soqlTask {

    public static void soqlMethod(){
        map<id,List<contact>> mapAccountContact = new map<id,List<contact>>();
        List<Account> lstAccount = [SELECT id,name, (SELECT Id, Name FROM Contacts) FROM Account WHERE id in (SELECT accountID FROM Contact)];
        for(Account acc : lstAccount)
                    {
                        mapAccountContact.put(acc.id, acc.Contacts);
                    }

                    System.debug(mapAccountContact);
 
       
    }
    
    public static void soqlMethod1(){
       map<id,List<contact>> mapAccountContact = new map<id,List<contact>>();
        List<Account> lstAccount = [SELECT id,name, (SELECT Id, Name FROM Contacts) FROM Account WHERE id in (SELECT accountID FROM Contact where phone='1234')];
        for(Account acc : lstAccount)
                    {
                        mapAccountContact.put(acc.id, acc.Contacts);
                    }

                    System.debug(mapAccountContact);
 
               
    }
    
    public static void soqlMethod2(){
        map<String,list<opportunityLineItem>> oppLineItem = new map<String,list<opportunityLineItem>>();
        List<opportunity> oppIds= [SELECT id,name,(SELECT id,name FROM opportunitylineitems) FROM opportunity where id in(select opportunityid from opportunityLineItem)];
    // WHERE id in (SELECT opportunityid FROM opportunitylineitem)
        for(opportunity op : oppIds)
                    {
                        oppLineItem.put(op.name, op.opportunityLineItems);
                    }

                    System.debug(oppLineItem);
        
    }

       public static void soqlMethod3(){
        
       map<String,list<quote>> oppLineItem = new map<String,list<quote>>();
        List<opportunity> oppIds= [select id,name,(select id,name from quotes) from opportunity where id in (select opportunityid from quote)];
    // WHERE id in (SELECT opportunityid FROM opportunitylineitem)
        for(opportunity op : oppIds)
                    {
                        oppLineItem.put(op.name, op.quotes);
                    }

                    System.debug(oppLineItem);
       
    }
     
    public static void soqlMethod4(){
        
       map<String,list<contact>> acclist = new map<String,list<contact>>();
        List<account> conlist=[select id,name,annualrevenue,(select id,name from contacts) from account where id in (select accountid from contact)];
 
        for(account c : conlist)
                    {
                        acclist.put(c.name, c.contacts);
                    }

                    System.debug(acclist);
       
    }
    
    public static void soqlMethod5(){
        
        List<aggregateResult> conlist=[select sum(amount) from opportunity where stageName='closed won'];
 
        System.debug(conlist);
       
    }
    
    
    
     
    
}