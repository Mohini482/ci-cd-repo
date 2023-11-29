trigger phoneAndNamefieldUpdate on Account (before insert) {
    public static void  beforeUpdate(Map<id,account> mapAccount,Map<id,account> mapOldAccount)
    {
        List<account> lstAccount =  mapAccount.values();
        //System.debug(lstaccount);
        for(Account a: lstAccount)
        {
            if(a.phone!=mapOldAccount.get(a.id).Phone)
            {
                String name=a.name;
                integer index=name.indexOf('-');
                if(index>0)
                {
                    a.name=name.substring(0,index)+'-'+a.Phone;
                }
                else
                {
                a.name=a.name+'-'+a.Phone;
            }   }
            
            
}
    }
}