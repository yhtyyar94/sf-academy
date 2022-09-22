public class AccountProcessor {
   @future
   public static void countContacts(List<Id> accountIds){
    List<Account> accounts = [Select Id, Name, Number_Of_Contacts__c, (Select Id From Contacts) From Account Where Id In :accountIds];
    System.debug(accountIds);
    for (Account acc : accounts) {
        acc.Number_Of_Contacts__c = acc.Contacts.size(); 
    }
    update accounts;
   }
}
