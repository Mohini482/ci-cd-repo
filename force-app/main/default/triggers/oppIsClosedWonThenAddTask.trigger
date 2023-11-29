trigger oppIsClosedWonThenAddTask on Opportunity (after insert, after update) {
    List<Task> addTask = new List<Task>();
    for(Opportunity op:trigger.new)
    {
    if(op.StageName=='closed won')
    {
    Task t = new Task(WhatId=op.Id, Subject='Hello, We are creating a new task');
    addTask.add(t);
    }
    }  
         
    insert addTask;

}