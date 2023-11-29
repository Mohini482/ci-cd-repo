public with sharing class QueuableExample implements Queueable{
    public List<Account> accList ; 
    public QueuableExample(List<Account> accList)
    { 
        this.accList = accList ; 
    } 
    public void execute(QueueableContext context)
     { 
         for(Account acc :accList)
         { 
             // Update the Account Name
           acc.Name = acc.Name +'V2 Solution'; 
         } update accList; 
     }
}