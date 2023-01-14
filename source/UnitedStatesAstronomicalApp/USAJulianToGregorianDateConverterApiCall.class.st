"
USAJulianToGregorianDateConverterApiCall example:

	| us |
	us := USAJulianToGregorianDateConverterApiCall new.
	us julianDateParm: 2453124.1526.
	us buildTheUrl; callTheApi.
	us inspect.

"
Class {
	#name : 'USAJulianToGregorianDateConverterApiCall',
	#superclass : 'USAJulianGregorianDateConverterApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAJulianToGregorianDateConverterApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'calendardate'.

]
