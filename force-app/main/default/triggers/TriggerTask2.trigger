trigger TriggerTask2 on Account (before insert) {

    list<Account> accList=new list<Account>();

    for(Account a :Trigger.new)
    {
      
    if( a.phone==null)
    {
      a.addError('You Cannot create record without phone');
      accList.add(a);
// System.debug('Hello, Error Occured');
    }
     /*else
      {
        System.debug('');
}*/
}
}