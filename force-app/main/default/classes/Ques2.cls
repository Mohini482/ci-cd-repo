public class Ques2 {
  public void ques2Method()
  {
      
        account acc = new account(name = 'newV2solutions');
        insert acc;
        contact con = new contact(firstname ='Mohini', lastname = 'Parolkar', accountid = acc.id);
        insert con;
        opportunity opp = new opportunity(name ='V2solutions opportunity', stagename = 'Prospecting' , closedate = date.today() +15 , accountid = acc.Id );
        insert opp;
        system.debug(acc);
 
  }
}