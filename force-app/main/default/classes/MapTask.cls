public class MapTask {
    
    public static void mapMethod()
    {
            
             set<id> accIds = new set<id>();
             Map<id,account> mapAccount = new Map<id,account> ([select id,name from account]);
             Map<id,list<Contact>> accContData = new Map<id,list<Contact>>();
            List<Account> lstAcct = new List<Account>();
      //  List<contact> updateContact = new List<contact>();

     /*   for(Account Acc:lstAcct )
        {
           accIds.add(Acc.id);
          mapAccount.put(Acc.id,Acc);
        }*/
             List<contact> contList = [select id,name,accountid from contact];
             for(contact c:contList)
              {
                if(accContData.containsKey(c.accountid))
                  {
                    accContData.get(c.accountid).add(c);
                  }
                  else
                  {
                    accContData.put(c.accountid,new list<contact>{c});
                  }
              }
              System.debug(accContData);
        
        for(id key:mapAccount.keySet())
{
    system.debug(mapAccount.get(key).name+' ==> '+acccontdata.get(key));
}
    
         /*   for(id accountID:accContData.keyset())
              {
                if(mapAccount.get(accountID)!= null)
                 {   

                   if(accContData.get(accountID)!=null)

                      {  //quering all contact related to Account id
                    List<contact> contList = accContData.get(accountID);
                    for(contact c:contList)
                    {
                        if(Contacts.name== true)
                        {
                        
                        }
                    }
              }  */ 
    }
}