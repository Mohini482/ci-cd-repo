trigger addProductTriggerHandler on Opportunity (after insert,after update) {
    if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
        addProductOnOpportunity.addProductOnOpportunity(trigger.new);
        addProductOnOpportunity.insertRevenueGenerate(trigger.new);
        }

        if(trigger.isUpdate)
        {
            addProductOnOpportunity.updateRevenueGenerate(trigger.new);
        }
    }


   // addProductOnOpportunity.addProductOnOpportunity(trigger.new);
     
   // addProductOnOpportunity.insertRevenueGenerate(trigger.new);
}