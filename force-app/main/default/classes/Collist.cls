public class Collist {
     public static void myProg()
     {
         list<Integer> lst = new list<Integer>();
         
        // To assign data to the list :-
        // 1. static
        
         list<Integer> lst1=new list<Integer>{ 1,2,3,4,1,3,5,6};
       //  System.debug(lst1);
       
       // Using for loop:-  
         for(integer i=0;i<lst1.size();i++)
         {
             System.debug(lst1[i]);
         }
         
       // Using for each loop:-
       for(integer l : lst1)
       {
           System.debug(l);
       }
         
         // 2D list:-
         list<list<integer>> lst2d = new  list<list<integer>>{ new list<integer> {4,3,5}, new list<integer>{1,2,3}};
         System.debug(lst2d);
             }
}