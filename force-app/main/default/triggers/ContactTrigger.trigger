trigger ContactTrigger on Contact (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactHandler.afterInsert(Trigger.new);
        }
    }
}