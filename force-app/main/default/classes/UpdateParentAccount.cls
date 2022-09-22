public with sharing class UpdateParentAccount implements Queueable {

    private List<Account> accounts;
    private Id parentId;

    //constructor
    public UpdateParentAccount(List<Account> accounts, Id parentId) {
        this.accounts = accounts;
        this.parentId = parentId;
    }

    public void execute(QueueableContext qc){
        for(Account acc : this.accounts){
            acc.ParentId = this.parentId;
        }
        update this.accounts;
    }
}
