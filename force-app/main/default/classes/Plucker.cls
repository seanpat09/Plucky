public with sharing class Plucker {
	private Object pluck(String field, sObject obj) {
		return obj.get(field);
	}

	public Set<Object> pluck(String field, List<sObject> objs) {
		Set<Object> plucked = new Set<Object>();

		for (sObject obj : objs) {
			Object val = pluck(field, obj);
			if (val != null) {
				plucked.add(val);
			}
		}

		return plucked;
	}

	public Set<Date> pluckDates(String field, List<sObject> objs) {
		Set<Date> plucked = new Set<Date>();

		for (sObject obj : objs) {
			Date val = (Date) pluck(field, obj);
			if (val != null) {
				plucked.add(val);
			}
		}

		return plucked;
	}

	public Set<Datetime> pluckDatetimes(String field, List<sObject> objs) {
		Set<Datetime> plucked = new Set<Datetime>();

		for (sObject obj : objs) {
			Datetime val = (Datetime) pluck(field, obj);
			if (val != null) {
				plucked.add(val);
			}
		}

		return plucked;
	}

	public Set<Decimal> pluckDecimals(String field, List<sObject> objs) {
		Set<Decimal> plucked = new Set<Decimal>();

		for (sObject obj : objs) {
			Decimal val = (Decimal) pluck(field, obj);
			if (val != null) {
				plucked.add(val);
			}
		}

		return plucked;
	}

	public Set<Integer> pluckIntegers(String field, List<sObject> objs) {
		Set<Integer> plucked = new Set<Integer>();

		for (sObject obj : objs) {
			Integer val = (Integer) pluck(field, obj);
			if (val != null) {
				plucked.add(val);
			}
		}

		return plucked;
	}

	public Map<Id, Set<sObject>> fieldToSObjects(
		String field,
		List<sObject> objs
	) {
		Map<Id, Set<sObject>> objTosObjects = new Map<Id, Set<sObject>>();
		for (sObject obj : objs) {
			Id fieldVal = (Id) obj.get(field);
			if (!objTosObjects.containsKey(fieldVal)) {
				objTosObjects.put(fieldVal, new Set<sObject>());
			}
			objTosObjects.get(fieldVal).add(obj);
		}
		return objTosObjects;
	}

	public Set<Id> pluckIds(List<sObject> objs) {
		Map<Id, sObject> objectMap = new Map<Id, sObject>();
		objectMap.putAll(objs);
		//Clone to avoid issues of returning objects that are not mutable (i.e. Trigger.newMap().keySet())
		return objectMap.keySet().clone();
	}

	public Set<Id> pluckIds(String field, List<sObject> objs) {
		Set<Id> plucked = new Set<Id>();

		for (sObject obj : objs) {
			Id val = (Id) pluck(field, obj);
			if (val != null) {
				plucked.add(val);
			}
		}

		return plucked;
	}

	public Set<String> pluckStrings(String field, List<sObject> objs) {
		Set<String> plucked = new Set<String>();

		for (sObject obj : objs) {
			String val = (String) pluck(field, obj);
			if (val != null) {
				plucked.add(val);
			}
		}

		return plucked;
	}
}
