trigger duplicateEmailInContacts on Contact (before insert) {
    Set<String> newEmail=new Set<String>();
    Set<String> setExistingEmail=new Set<String>();
    for(Contact ct : Trigger.new)
   {
       newEmail.add(ct.email);

    }
    for(contact  ct : [select email from contact where email in : newEmail])
    {
           setExistingEmail.add(ct.email);
 
    }
    
    if(Trigger.isInsert||Trigger.isUpdate)
    for(contact c:trigger.new)
    {
        if(setExistingEmail.contains(c.email))
       {
                c.Email.adderror('Sry, Pls solve your error');
         }
}
}