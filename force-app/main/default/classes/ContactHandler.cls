public class ContactHandler {
    public static void afterInsert(List<Contact> newContacts){
        List<Id> accountIds = new List<Id>();

        for (Contact con : newContacts) {
            accountIds.add(con.AccountId);
        }

        AccountProcessor.countContacts(accountIds);
    }
}
