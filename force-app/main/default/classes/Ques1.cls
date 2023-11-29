public class Ques1 {
  Public  void FetchAccName(String p) { 
        Set<String> s1= new Set<String>();
        List<Account> acc=[Select id, Name From Account where phone=:p];
        for(Account a:acc)
           
        {
           
            String s =a.name;
             String s2 =a.Id;
            s1.add(s);
            s1.add(s2);
           
        }
       
        System.debug('The Account Record Matching the Phone' +s1);
    }
}