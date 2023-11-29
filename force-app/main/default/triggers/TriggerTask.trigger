trigger TriggerTask on Account (before insert) {
    list<Account> accList=new list<Account>();

    for(Account a :Trigger.new)
    {
      
    if( a.description!=null)
    {
      a.Description='Hello, There is no error';
      accList.add(a);
// System.debug('Hello, Error Occured');
    }
     /*else
      {
        System.debug('');
}*/
}
}