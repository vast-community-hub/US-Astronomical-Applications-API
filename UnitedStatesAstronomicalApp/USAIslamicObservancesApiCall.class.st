"
""Selected Islamic Observances"" see: https://aa.usno.navy.mil/data/api#islamiccal

	This data service provides the dates for Islamic New Year, the first day of Ramadân,
	and the first day of Shawwál in a given year.
	Data will be provided for the years 622 C.E. (A.H. 1) through 9999 C.E. (A.H. 9666).
	No observances will be provided prior to A.H. 1 in 622 C.E..
	More information about this data service may be found at: https://aa.usno.navy.mil/data/islamic_observances

USAIslamicObservancesApiCall example:

	| us |
	us := USAIslamicObservancesApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us observances inspect.
	us inspect.

"
Class {
	#name : 'USAIslamicObservancesApiCall',
	#superclass : 'USAObservancesApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAIslamicObservancesApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'observances/islamic'.

]

{ #category : 'Not categorized' }
USAIslamicObservancesApiCall class >> observanceDataClass [
	"The class of out observance data."

	^USAIslamicObservanceData.

]

{ #category : 'Not categorized' }
USAIslamicObservancesApiCall >> islamicNewYear [
	"Answer the data for Islamic New Year."

	^(values select: [:o | o isIslamicNewYear]) first.

]

{ #category : 'Not categorized' }
USAIslamicObservancesApiCall >> ramadan [
	"Answer the data for Ramadan."

	^(values select: [:o | o isRamadan]) first.

]

{ #category : 'Not categorized' }
USAIslamicObservancesApiCall >> shawwal [
	"Answer the data for Shawwal."

	^(values select: [:o | o isShawwal]) first.

]
