trigger productAndSupportedParts on Product__c (after insert) {
    list<Supported__c> supportedList = new list<Supported__c>();
    list<Product__c> machineDetailsList = new list<Product__c>([select id,Machine_Name__c,Machine_Brand_Name__c,Machine_Model_Number__c,RecordType.name from Product__c where RecordType.name='machine']);
    list<Product__c> partsDetailsList = new list<Product__c>([select id,Parts_Name__c,Parts_Brand_Name__c,Parts_Model_Number__c,RecordType.name from Product__c where RecordType.name='parts']);
  
    for(Product__c  machineRecord :[SELECT id,Machine_Name__c,Machine_Brand_name__c,Machine_Model_Number__c,RecordType.Name FROM Product__c WHERE RecordType.Name = 'Machine' AND id IN :trigger.new])
    {
        for(Product__c partsRecord :partsDetailsList)
        {
            if(machineRecord.Machine_Brand_name__c == partsRecord.Parts_Brand_name__c && partsRecord.Parts_Model_Number__c==null)
            {
                supportedList.add(new Supported__c( Parts_Lookup__c= partsRecord.id,Machine_Lookup__c = machineRecord.id));
            }

            if(machineRecord.Machine_Brand_name__c == partsRecord.Parts_Brand_name__c && machineRecord.Machine_Model_Number__c == partsRecord.Parts_Model_Number__c)
            {
                supportedList.add(new Supported__c( Parts_Lookup__c= partsRecord.id,Machine_Lookup__c = machineRecord.id));
            }

            if(partsRecord.Parts_Brand_name__c == null && partsRecord.Parts_Model_Number__c == null)
            {
                supportedList.add(new Supported__c( Parts_Lookup__c= partsRecord.id,Machine_Lookup__c = machineRecord.id));
            }
        }
    }

    for(Product__c partsRecord :[SELECT id,Parts_Name__c,Parts_Brand_Name__c,Parts_Model_Number__c,RecordType.Name FROM Product__c WHERE RecordType.Name = 'Parts' AND id IN :trigger.new])
    {
        for(Product__c machineRecord :machineDetailsList)
        {
            if(machineRecord.Machine_Brand_name__c == partsRecord.Parts_Brand_name__c && partsRecord.Parts_Model_Number__c==null)
            {
               supportedList.add(new Supported__c(Parts_Lookup__c = partsRecord.id,Machine_Lookup__c = machineRecord.id));
            }

            if(machineRecord.Machine_Brand_name__c == partsRecord.Parts_Brand_name__c && machineRecord.Machine_Model_Number__c == partsRecord.Parts_Model_Number__c)
            {
               supportedList.add(new Supported__c(Parts_Lookup__c = partsRecord.id,Machine_Lookup__c = machineRecord.id));
            }

            if(partsRecord.Parts_Brand_name__c == null && partsRecord.Parts_Model_Number__c == null)
            {
                  //  supportedList.add(new Supported___c(Parts_Lookup__c= partsRecord.id,Machine_Lookup__c = machineRecord.id));
                  supportedList.add(new Supported__c(Parts_Lookup__c = partsRecord.id,Machine_Lookup__c = machineRecord.id));
            }
        }     
    }
    insert supportedList;
}