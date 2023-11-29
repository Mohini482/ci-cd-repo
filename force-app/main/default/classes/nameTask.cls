public class nameTask {

    public static void nameMethod()
    {
        map<string,List<contact>> mapAccountContact = new map<String,List<contact>>();
        List<Account> lstAccount = [SELECT id,name, (SELECT Id, Name FROM Contacts) FROM Account WHERE id in (SELECT accountID FROM Contact)];
        for(Account acc : lstAccount)
                    {
                        mapAccountContact.put(acc.Name, acc.Contacts);
                    }

                    System.debug(mapAccountContact);
 
      
    }
 
}