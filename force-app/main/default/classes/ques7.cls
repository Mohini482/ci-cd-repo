public class ques7 {
public void ques7Method()
   {
       list<list<account>> lac =[Find 'Test' in all fields RETURNING Account(id,name)];
       list<list<contact>> lcc =[Find 'Test' in all fields RETURNING Contact(id,name)];
       System.debug(lac);
       System.debug(lcc);
   }
}