"
""Selected Christian Observances"" see: https://aa.usno.navy.mil/data/api#easter

	This data service provides the dates of Ash Wednesday, Palm Sunday, Good Friday,
	Easter, Ascension Day, Whit Sunday, Trinity Sunday, and the First Sunday of Advent in a given year.
	Data will be provided for the years 1583 through 9999.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/christian_observances

USAChristianObservancesApiCall example:

	| us |
	us := USAChristianObservancesApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us observances inspect.
	us inspect.

"
Class {
	#name : 'USAChristianObservancesApiCall',
	#superclass : 'USAObservancesApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAChristianObservancesApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'observances/christian'.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall class >> observanceDataClass [
	"The class of out observance data."

	^USAChristianObservanceData.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> advent [
	"Answer the data for First Sunday in Advent."

	^(values select: [:o | o isAdvent]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> ascensionDay [
	"Answer the data for Ascension Day."

	^(values select: [:o | o isAscensionDay]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> ashWednesday [
	"Answer the data for Ash Wednesday."

	^(values select: [:o | o isAshWednesday]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> easter [
	"Answer the data for Easter."

	^(values select: [:o | o isEaster]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> goodFriday [
	"Answer the data for Good Friday."

	^(values select: [:o | o isGoodFriday]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> palmSunday [
	"Answer the data for Palm Sunday."

	^(values select: [:o | o isPalmSunday]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> pentecost [
	"Answer the data for Whit Sunday -- Pentecost."

	^(values select: [:o | o isPentecost]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> trinitySunday [
	"Answer the data for Trinity Sunday."

	^(values select: [:o | o isTrinitySunday]) first.

]

{ #category : 'Not categorized' }
USAChristianObservancesApiCall >> whitSunday [
	"Answer the data for Whit Sunday -- Pentecost."

	^(values select: [:o | o isWhitSunday]) first.

]
