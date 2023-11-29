public class soqlTask1 {
    public static void soqlMethod1()
    {
      list<opportunity> opp = [select id,name,closedate from opportunity where createddate = This_Month];
      for(opportunity a:opp)
       {
         if(a.closedate!=null)
         {
          a.closedate = date.today()+15;
         }
       }

update opp;
system.debug(opp);
}
}