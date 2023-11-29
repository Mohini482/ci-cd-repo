public class Ques6 {
     public void ques6Method()
         
     {
         list<contact> ls = [select id,name from contact where Name='Singh'];
         delete ls;
         database.emptyRecycleBin(ls);
     }
   }