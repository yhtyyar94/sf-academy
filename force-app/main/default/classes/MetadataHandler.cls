public with sharing class MetadataHandler {
    public static Decimal getTreshold(String allowanceType){
        allowanceType = allowanceType.replaceAll(' ', '_');
        Allowance_Treshold__mdt record = Allowance_Treshold__mdt.getInstance(allowanceType);

        return record.Treshold__c;
    }
}
