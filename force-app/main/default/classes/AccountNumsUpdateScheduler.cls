public with sharing class AccountNumsUpdateScheduler implements Schedulable {
   public void execute(SchedulableContext sc){
    AccountNumsUpdateBatch batchable = new AccountNumsUpdateBatch();
    Database.executeBatch(batchable);
   }
}
