trigger leadTask on Lead (before insert,before update) {

    Set<String> newEmail=new Set<String>();
    Set<String> setExistingEmail=new Set<String>();
    for(lead ld : Trigger.new)
   {
       newEmail.add(ld.email);

    }
    for(lead  ld : [select email from lead where email in : newEmail])
    {
           setExistingEmail.add(ld.email);
 
    }
    
    if(Trigger.isInsert||Trigger.isUpdate)
    for(lead a:trigger.new)
    {
        if(setExistingEmail.contains(a.email))
       {
                a.Email.adderror('Sry, Pls solve your error');
         }
}
}