trigger AllowanceTrigger on Allowance__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AllowanceHandler.beforeInsert(Trigger.new);
        } else if(Trigger.isUpdate){
            AllowanceHandler.beforeUpdate(Trigger.new, Trigger.old);
        } else if(Trigger.isDelete){
            AllowanceHandler.beforeDelete(Trigger.old);
        }
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AllowanceHandler.afterInsert(Trigger.new);
        } else if(Trigger.isUpdate){
            AllowanceHandler.afterUpdate(Trigger.new, Trigger.old);
        }
    }
}