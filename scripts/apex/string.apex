// String Class Methods

//equals
String str1 = 'Salesforce';
String str2 = 'Salesforce Developer';

Boolean isEqual = str1.equals(str2);

System.debug(isEqual);

Long longTime = 999999999999999L;
Datetime dt = Datetime.newInstance(longTime);
System.debug(dt);

Map<string, string> mp = new Map<string, string>{'1'=>'2'};
mp.put('arg0', 'arg1');
mp.put('arg0', 'arg2');
System.debug(mp);

List<Account> accs = [Select Name, AccountNumber, Industry, Type, Rating From Account ORDER BY Type];
System.debug(accs);
System.debug(Limits.getDmlStatements());