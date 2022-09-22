public with sharing class AllowanceHandler {
   public static void beforeInsert(List<Allowance__c> newAllowances){
    checkTresholds(newAllowances);
   }

   public static void beforeUpdate(List<Allowance__c> newAllowances, List<Allowance__c> oldAllowances){
    checkTresholds(newAllowances);
    
   }
  
   public static void beforeDelete(List<Allowance__c> oldAllowances){
    
   }

   public static void afterInsert(List<Allowance__c> newAllowances){

   }

   public static void afterUpdate(List<Allowance__c> newAllowances, List<Allowance__c> oldAllowances){
    Map<Id,Decimal> accIdVsAmount = new Map<Id,Decimal>();
    for (Allowance__c al : newAllowances) {
        if(al.Status__c == 'Approved'){
            accIdVsAmount.put(al.Account__c, al.Amount__c);
        }
    }

    if(!accIdVsAmount.isEmpty()){
        updateAccounts(accIdVsAmount);
    }
}

   public static void checkTresholds(List<Allowance__c> allowances){
        for(Allowance__c al : allowances){
            Decimal treshold = MetadataHandler.getTreshold(al.Allowance_Type__c);
            if(al.Amount__c > treshold){
                al.addError(Label.Allowance_Treshold.replace('allowancetype', al.Allowance_Type__c).replace('allowanceamount', String.valueOf(treshold)));
            }
            // if(al.Allowance_Type__c == 'Leave Travel Allowance' && al.Amount__c > 2000){
            //     al.addError(Label.Allowance_Treshold + al.Allowance_Type__c + ' is 2000');
            // } else if (al.Allowance_Type__c == 'House Rent Allowance' && al.Amount__c > 10000) {
            //     al.addError(Label.Allowance_Treshold + al.Allowance_Type__c + ' is 10000');
            // } else if(al.Allowance_Type__c == 'Well Being Allowance' && al.Amount__c > 15000){
            //     al.addError(Label.Allowance_Treshold + al.Allowance_Type__c + ' is 10000');
            // } else if(al.Allowance_Type__c == 'Cab Allowance' && al.Amount__c > 1000){
            //     al.addError(Label.Allowance_Treshold + al.Allowance_Type__c + ' is 10000');
            // } else if(al.Allowance_Type__c == 'Work From Home Allowance' && al.Amount__c > 12000){
            //     al.addError(Label.Allowance_Treshold + al.Allowance_Type__c + ' is 12000');
            // }
        }
   }

   public static void updateAccounts(Map<Id,Decimal> accIdVsAmount){
    List<Account> accounts = [Select Id, Approved_Allowance_Amount__c From Account Where Id = :accIdVsAmount.keySet()];

    for (Account acc : accounts) {
        acc.Approved_Allowance_Amount__c = acc.Approved_Allowance_Amount__c + accIdVsAmount.get(acc.Id);
    }

    try {
        System.debug(accIdVsAmount.keySet());
        update accounts;
    } catch (Exception ex) {
        
    }
   }
}