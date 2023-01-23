"
""Selected Jewish Observances"" see: https://aa.usno.navy.mil/data/api#passover

	This data service provides the dates for Rosh Hashanah (Jewish New Year),
	Yom Kippur (Day of Atonement), first day of Succoth (Feast of Tabernacles),
	Hanukkah (Festival of Lights), first day of Pesach (Passover), and Shavuot (Feast of Weeks) in a given year.
	Data will be provided for the years 360 C.E. (A.M. 4120) through 9999 C.E. (A.M. 13761).
	More information about this data service may be found at: https://aa.usno.navy.mil/data/jewish_observances

USAJewishObservancesApiCall example:

	| us |
	us := USAJewishObservancesApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us observances inspect.
	us inspect.
"
Class {
	#name : 'USAJewishObservancesApiCall',
	#superclass : 'USAObservancesApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAJewishObservancesApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'observances/jewish'.

]

{ #category : 'Not categorized' }
USAJewishObservancesApiCall class >> observanceDataClass [
	"The class of out observance data."

	^USAJewishObservanceData.

]

{ #category : 'Not categorized' }
USAJewishObservancesApiCall >> hanukkah [
	"Answer the data for Hanukkah."

	^(values select: [:o | o isHanukkah]) first.

]

{ #category : 'Not categorized' }
USAJewishObservancesApiCall >> passover [
	"Answer the data for Passover."

	^(values select: [:o | o isPassover]) first.

]

{ #category : 'Not categorized' }
USAJewishObservancesApiCall >> roshHashanah [
	"Answer the data for Rosh Hashanah."

	^(values select: [:o | o isRoshHashanah]) first.

]

{ #category : 'Not categorized' }
USAJewishObservancesApiCall >> shavuot [
	"Answer the data for Shavuot."

	^(values select: [:o | o isShavuot]) first.

]

{ #category : 'Not categorized' }
USAJewishObservancesApiCall >> succoth [
	"Answer the data for Succoth."

	^(values select: [:o | o isSuccoth]) first.

]

{ #category : 'Not categorized' }
USAJewishObservancesApiCall >> yomKippur [
	"Answer the data for Yom Kippur."

	^(values select: [:o | o isYomKippur]) first.

]
