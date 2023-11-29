// Schedule apex class which will  fetch all the opportunities which ar created in this month and set their stage name as closed won and date as today.

public with sharing class scheduleTaskOnOpportunity implements Schedulable {
    
    public void execute(SchedulableContext SC)
     {

        List<Opportunity> oppList= [select id,name,closeDate,stageName from Opportunity where CreatedDate=THIS_MONTH];
        for(Opportunity opl :oppList)
        {
            opl.StageName='Closed Won';
            opl.CloseDate=System.today();
        }  
        
     }
}