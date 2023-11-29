public with sharing class AccountHelper {
    
        @AuraEnabled
        public static void createAccount(String name, String phone, String parentRecordId){
            try {
                Account acc = new Account(Name = name, Phone = phone, ParentId = parentRecordId);
                insert acc;
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    }

