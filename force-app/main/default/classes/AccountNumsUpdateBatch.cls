public with sharing class AccountNumsUpdateBatch implements Database.Batchable<sobject>, Database.Stateful{

    private final String DEF_ACC_NUM = 'ABC123456';
    private Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'Select Id, AccountNumber From Account Where AccountNumber = null';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<sObject> scope){
        List<Account> accounts = (List<Account>)scope;
        for (Account acc : accounts) {
            acc.AccountNumber = DEF_ACC_NUM;
        }
        update accounts;
        recordsProcessed += accounts.size();
    }

    public void finish(Database.BatchableContext bc){
        List<Messaging.SingleEmailMessage> msgs = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage  msg = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new List<String>();
        toAddresses.add('blackeagle4894@gmail.com');
        msg.setToAddresses(toAddresses);
        msg.setSubject('Accounts Processing Complete');
        msg.setPlainTextBody('The accounts processing has been completed. \n Records Processes: ' + recordsProcessed);
        msgs.add(msg);
        Messaging.sendEmail(msgs);
    }
}
