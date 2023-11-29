public class Ques9 {
   public void ques9Method()
   {
       list<aggregateResult> ls=[select sum(amount),account.name from opportunity group by account.name];
       System.debug(ls);
    
   }
}