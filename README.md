<img src="assets/logo.svg" height="128" alt="">

 # Plucker 

This is a library to get a set a values plucked from a list of sObject. It also contains a helper method to group a records by a given field.

## Notes
Instance methods are used instead of static methods to allow for mocking in tests. 

Nulls are skipped and not included in the sets.

Why isn't this a package? There's no guarantee that I will continue maintaining any package, which could potentially create a dependency in your org that can never be updated. This could be especially problematic if there is a security update. You could manage this dependency using submodules in your org. Plus this allows you to fork the repo, customize, and maintain it yourself should you need to.

## Public Methods
```
Object pluck(String field, sObject obj) 
Set<Object> pluck(String field, List<sObject> objs) 
Set<Date> pluckDates(String field, List<sObject> objs) 
Set<Datetime> pluckDatetimes(String field, List<sObject> objs) 
Set<Decimal> pluckDecimals(String field, List<sObject> objs) 
Set<Integer> pluckIntegers(String field, List<sObject> objs) 
Map<Id, Set<sObject>> fieldToSObjects(
Set<Id> pluckIds(List<sObject> objs) 
Set<Id> pluckIds(String field, List<sObject> objs) 
Set<String> pluckStrings(String field, List<sObject> objs) 
```