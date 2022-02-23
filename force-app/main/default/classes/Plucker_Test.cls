@isTest
private with sharing class Plucker_Test {
	@isTest
	private static void pluckObject() {
		Lead johnny = new Lead(
			FirstName = 'Johnny',
			LastName = 'Five',
			Company = 'Johnny Co'
		);
		Lead julie = new Lead(
			FirstName = 'Julie',
			LastName = 'Five',
			Company = 'Julie Co'
		);
		Lead jamby = new Lead(
			FirstName = 'Jamby',
			LastName = 'Five',
			Company = 'Jamby Co'
		);

		List<Lead> allLeads = new List<Lead>{ johnny, julie, jamby };

		Test.startTest();
		Set<Object> actualNames = new Plucker().pluck('FirstName', allLeads);
		Test.stopTest();

		System.assert(
			actualNames.contains(johnny.FirstName),
			'The FirstNames of the sObjects should be plucked'
		);
		System.assert(
			actualNames.contains(julie.FirstName),
			'The FirstNames of the sObjects should be plucked'
		);
		System.assert(
			actualNames.contains(jamby.FirstName),
			'The FirstNames of the sObjects should be plucked'
		);
	}

	@isTest
	private static void pluckDatesIgnoresNulls() {
		Lead johnny = new Lead();

		Test.startTest();
		Set<Date> actualDates = new Plucker().pluckDates(
			'CreatedDate',
			new List<sObject>{ johnny }
		);
		Test.stopTest();

		System.assert(actualDates.isEmpty(), 'null values should be ignored');
	}

	@isTest
	private static void pluckDatesTest() {
		Date tomorrow = Date.today().addDays(1);
		Date nextWeek = Date.today().addDays(7);
		Date nextMonth = Date.today().addDays(30);
		Opportunity bigSale = new Opportunity(
			Name = 'Sell a lot',
			CloseDate = tomorrow,
			StageName = 'Qualification'
		);
		Opportunity biggerSale = new Opportunity(
			Name = 'Sell it all',
			CloseDate = nextWeek,
			StageName = 'Qualification'
		);
		Opportunity biggestSale = new Opportunity(
			Name = 'Permanent vacation',
			CloseDate = nextMonth,
			StageName = 'Qualification'
		);

		List<Opportunity> allOpportunitiesList = new List<Opportunity>{
			bigSale,
			biggerSale,
			biggestSale
		};

		Test.startTest();
		Set<Date> actualDatesList = new Plucker().pluckDates(
			'CloseDate',
			allOpportunitiesList
		);
		Test.stopTest();

		System.assert(
			actualDatesList.contains(tomorrow),
			'The sObject Close Date should be plucked'
		);
		System.assert(
			actualDatesList.contains(nextWeek),
			'The sObject Close Date should be plucked'
		);
		System.assert(
			actualDatesList.contains(nextMonth),
			'The sObject Close Date should be plucked'
		);
	}


	@isTest
	private static void pluckDatetimesIgnoresNulls() {
		Lead johnny = new Lead();

		Test.startTest();
		Set<Datetime> actualDatetimes = new Plucker().pluckDatetimes(
			'CreatedDate',
			new List<sObject>{ johnny }
		);
		Test.stopTest();

		System.assert(
			actualDatetimes.isEmpty(),
			'null values should be ignored'
		);
	}

	@isTest
	private static void pluckDatetimesTest() {
		Event birthdayParty = new Event(ActivityDateTime = DateTime.now());
		Event cookout = new Event(ActivityDateTime = DateTime.now().addDays(1));
		Event boxSocial = new Event(
			ActivityDateTime = DateTime.now().addDays(2)
		);

		List<Event> allEvents = new List<Event>{
			birthdayParty,
			cookout,
			boxSocial
		};

		Test.startTest();
		Set<Datetime> actualDatetimesList = new Plucker().pluckDatetimes(
			'ActivityDateTime',
			allEvents
		);
		Test.stopTest();

		System.assert(
			actualDatetimesList.contains(birthdayParty.ActivityDateTime),
			'The sObjects Created Date should be plucked'
		);
		System.assert(
			actualDatetimesList.contains(cookout.ActivityDateTime),
			'The sObjects Created Date should be plucked'
		);
		System.assert(
			actualDatetimesList.contains(boxSocial.ActivityDateTime),
			'The sObjects Created Date should be plucked'
		);
	}

	private static testMethod void pluckDecimalsIgnoresNulls() {
		Opportunity bigSale = new Opportunity();

		Test.startTest();
		Set<Decimal> actualDecimals = new Plucker().pluckDecimals(
			'Amount',
			new List<sObject>{ bigSale }
		);
		Test.stopTest();

		System.assert(
			actualDecimals.isEmpty(),
			'null values should be ignored'
		);
	}

	@isTest
	private static void pluckDecimalsTest() {
		Decimal tonsOfMoney = 1337.02;
		Decimal evenMoreMoney = 42069.96;
		Decimal notALot = 2.13;
		Opportunity bigSale = new Opportunity(
			Name = 'Sell a lot',
			CloseDate = Date.today(),
			Amount = tonsOfMoney,
			StageName = 'Qualification'
		);
		Opportunity biggerSale = new Opportunity(
			Name = 'Sell a lot',
			CloseDate = Date.today(),
			Amount = evenMoreMoney,
			StageName = 'Qualification'
		);
		Opportunity smallSale = new Opportunity(
			Name = 'Sell a lot',
			CloseDate = Date.today(),
			Amount = notALot,
			StageName = 'Qualification'
		);

		List<Opportunity> allOpportunities = new List<Opportunity>{
			bigSale,
			biggerSale,
			smallSale
		};

		Test.startTest();
		Set<Decimal> actualDecimalsList = new Plucker().pluckDecimals(
			'Amount',
			allOpportunities
		);
		Test.stopTest();

		System.assert(
			actualDecimalsList.contains(tonsOfMoney),
			'The sObject Amount should be plucked'
		);
		System.assert(
			actualDecimalsList.contains(evenMoreMoney),
			'The sObject Amount should be plucked'
		);
		System.assert(
			actualDecimalsList.contains(notALot),
			'The sObject Amount should be plucked'
		);
	}

	@isTest
	private static void pluckIntegersIgnoresNulls() {
		Account smallAccount = new Account();

		Test.startTest();
		Set<Integer> actualIntegers = new Plucker().pluckIntegers(
			'NumberOfEmployees',
			new List<sObject>{ smallAccount }
		);
		Test.stopTest();

		System.assert(
			actualIntegers.isEmpty(),
			'null values should be ignored'
		);
	}

	@isTest
	private static void pluckIntegersTest() {
		Integer smallFirm = 75;
		Integer mediumFirm = 90;
		Integer tinyFirm = 2;
		Account smallAccount = new Account(NumberOfEmployees = smallFirm);
		Account mediumAccount = new Account(NumberOfEmployees = mediumFirm);
		Account tinyAccount = new Account(NumberOfEmployees = tinyFirm);

		List<Account> allAccounts = new List<Account>{
			smallAccount,
			mediumAccount,
			tinyAccount
		};

		Test.startTest();
		Set<Integer> actualIntegersList = new Plucker().pluckIntegers(
			'NumberOfEmployees',
			allAccounts
		);
		Test.stopTest();

		System.assert(
			actualIntegersList.contains(smallFirm),
			'The sObject Employees should be plucked'
		);
		System.assert(
			actualIntegersList.contains(mediumFirm),
			'The sObject Employees should be plucked'
		);
		System.assert(
			actualIntegersList.contains(tinyFirm),
			'The sObject Employees should be plucked'
		);
	}

	private static void pluckIdsTest() {
		Lead johnny = new Lead(
			Id = '00Q0000000XXXXX',
			FirstName = 'Johnny',
			LastName = 'Five',
			Company = 'Johnny Co'
		);

		Lead jamby = new Lead(
			Id = '00Q0000000XXXX3',
			FirstName = 'Jamby',
			LastName = 'Five',
			Company = 'Jamby Co'
		);

		Test.startTest();
		Set<Id> actualIds = new Plucker().pluckIds('Id', new List<Lead>{ johnny, jamby });
		Test.stopTest();

		System.assert(
			actualIds.contains(johnny.Id),
			'The sObject id should be plucked'
		);
		System.assert(
			actualIds.contains(jamby.Id),
			'The sObject id should be plucked'
		);
	}

	@isTest
	private static void pluckIdsIgnoresNulls() {
		Lead johnny = new Lead();

		Test.startTest();
		Set<Id> actualIds = new Plucker().pluckIds('Id', new List<sObject>{ johnny });
		Test.stopTest();

		System.assert(actualIds.isEmpty(), 'null values should be ignored');
	}

	@isTest
	private static void fieldToSObjects() {
		final Id OPPTY_1 = '0067000000Us9A1AAJ';
		final Id OPPTY_2 = '0069000000Us7U1AAN';
		OpportunityLineItem oppty1Product1 = new OpportunityLineItem(
			Id = '00k7000000N0aqdAAB',
			OpportunityId = OPPTY_1
		);
		OpportunityLineItem oppty1Product2 = new OpportunityLineItem(
			Id = '00k7000000N0aqdAAC',
			OpportunityId = OPPTY_1
		);
		OpportunityLineItem oppty2Product1 = new OpportunityLineItem(
			Id = '00k7000000N0aqdAAD',
			OpportunityId = OPPTY_2
		);
		Map<Id, Set<sObject>> expectedOpptyToOLI = new Map<Id, Set<sObject>>{
			OPPTY_1 => new Set<sObject>{ oppty1Product1, oppty1Product2 },
			OPPTY_2 => new Set<sObject>{ oppty2Product1 }
		};

		Test.startTest();
		Map<Id, Set<sObject>> opptyToOLI = new Plucker().fieldToSObjects(
			'OpportunityId',
			new List<OpportunityLineItem>{
				oppty2Product1,
				oppty1Product1,
				oppty1Product2
			}
		);
		Test.stopTest();

		System.assertEquals(expectedOpptyToOLI, opptyToOLI, 'The OLIs should be mapped by OpportunityId');
		System.assertEquals(
			2,
			opptyToOLI.size(),
			'There are two distinct opportunity ids in this list of opportunity line items' +
			opptyToOLI
		);
		for (Id opptyId : opptyToOLI.keySet()) {
			System.assertEquals(true, expectedOpptyToOLI.containsKey(opptyId));
			System.assertEquals(
				expectedOpptyToOLI.get(opptyId).size(),
				opptyToOLI.get(opptyId).size(),
				'The number of opportunity line items belonging to this opportunity is' +
				expectedOpptyToOLI +
				':' +
				opptyToOLI
			);
			for (sObject oli : expectedOpptyToOLI.get(opptyId)) {
				System.assertEquals(
					true,
					opptyToOLI.get(opptyId).contains(oli),
					'The following opportunity should belong to this opportunity. Opportunity : ' +
					opptyId +
					' oli ' +
					oli
				);
			}
		}
	}

	@isTest
	private static void pluckIds() {
		Lead johnny = new Lead(
			Id = '00Q0000000XXXX1',
			FirstName = 'Johnny',
			LastName = 'Five',
			Company = 'Johnny Co'
		);
		Lead julie = new Lead(
			Id = '00Q0000000XXXX2',
			FirstName = 'Julie',
			LastName = 'Five',
			Company = 'Julie Co'
		);
		Lead jamby = new Lead(
			Id = '00Q0000000XXXX3',
			FirstName = 'Jamby',
			LastName = 'Five',
			Company = 'Jamby Co'
		);

		List<Lead> allLeads = new List<Lead>{ johnny, julie, jamby };

		Test.startTest();
		Set<Id> actualIdsList = new Plucker().pluckIds('Id', allLeads);
		Test.stopTest();

		System.assert(
			actualIdsList.contains(johnny.Id),
			'The Ids of the sObjects should be plucked'
		);
		System.assert(
			actualIdsList.contains(julie.Id),
			'The Ids of the sObjects should be plucked'
		);
		System.assert(
			actualIdsList.contains(jamby.Id),
			'The Ids of the sObjects should be plucked'
		);
	}

	@isTest
	private static void pluckIdsModifySetTest() {
		Lead julie = new Lead(
			Id = '00Q0000000XXXX2',
			FirstName = 'Julie',
			LastName = 'Five',
			Company = 'Julie Co'
		);
		Lead jamby = new Lead(
			Id = '00Q0000000XXXX3',
			FirstName = 'Jamby',
			LastName = 'Five',
			Company = 'Jamby Co'
		);

		List<Lead> allLeads = new List<Lead>{ julie };

		Test.startTest();
		Set<Id> ids = new Plucker().pluckIds(allLeads);

		ids.add(jamby.Id);
		Test.stopTest();

		System.assertEquals(
			2,
			ids.size(),
			'The Set returned from pluck.ids should be modifiable'
		);
	}

    @isTest
	private static void pluckIds_standardIdSugarMethod() {
		Lead jamby = new Lead(
			Id = '00Q0000000XXXX3',
			FirstName = 'Jamby',
			LastName = 'Five',
			Company = 'Jamby Co'
		);

		List<Lead> allLeadsList = new List<Lead>{ jamby };

		Test.startTest();
		Set<Id> actualIdsList = new Plucker().pluckIds(allLeadsList);
		Test.stopTest();

		System.assert(
			actualIdsList.contains(jamby.Id),
			'The Ids of the sObjects should be plucked from the list'
		);
	}

    @isTest
	private static void pluckStringsIgnoresNulls() {
		Lead johnny = new Lead();

		Test.startTest();
		Set<String> actualStrings = new Plucker().pluckStrings(
			'FirstName',
			new List<sObject>{ johnny }
		);
		Test.stopTest();

		System.assert(actualStrings.isEmpty(), 'null values should be ignored');
	}

	@isTest
    private static void pluckStrings() {
		Lead johnny = new Lead(
			FirstName = 'Johnny',
			LastName = 'Five',
			Company = 'Johnny Co'
		);
		Lead julie = new Lead(
			FirstName = 'Julie',
			LastName = 'Five',
			Company = 'Julie Co'
		);
		Lead jamby = new Lead(
			FirstName = 'Jamby',
			LastName = 'Five',
			Company = 'Jamby Co'
		);

		List<Lead> allLeads = new List<Lead>{ johnny, julie, jamby };

		Test.startTest();
		Set<String> actualNamesList = new Plucker().pluckStrings('FirstName', allLeads);
		Test.stopTest();

		System.assert(
			actualNamesList.contains(johnny.FirstName),
			'The FirstNames of the sObjects should be plucked'
		);
		System.assert(
			actualNamesList.contains(julie.FirstName),
			'The FirstNames of the sObjects should be plucked'
		);
		System.assert(
			actualNamesList.contains(jamby.FirstName),
			'The FirstNames of the sObjects should be plucked'
		);
	}
}
