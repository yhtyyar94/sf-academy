// grab the details needed to invoke queuable
List<Account> accounts = [Select Id, ParentId From Account Where ParentId = null And Name != 'sForce'];

Account parentAccount = [Select Id From Account Where Name = 'sForce' Limit 1];

// enqueue queuable
UpdateParentAccount upa = new UpdateParentAccount(accounts, parentAccount.Id);
System.enqueueJob(upa);


//Scheduler
String jobName = 'Accounts Cleanup Activity';
String sch = '20 30 8 10 10 ?';

AccountNumsUpdateScheduler schedulable = new AccountNumsUpdateScheduler();

//invoke schedulable
System.schedule(jobName, sch, schedulable);


