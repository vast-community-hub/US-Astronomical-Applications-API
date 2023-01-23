"
USAGregorianToJulianDateConverterApiCall examples:

	| us |
	us := USAGregorianToJulianDateConverterApiCall new.
	us dateParm: '2013-08-03'.
	us timeParm: '22:15:23.5'.
	us buildTheUrl; callTheApi.
	us inspect.

	| us |
	us := USAGregorianToJulianDateConverterApiCall new.
	us dateParm: '4-3-26'.
	us timeParm: '2:3:0.0'.
	us eraBC.
	us buildTheUrl; callTheApi.
	us inspect.

"
Class {
	#name : 'USAGregorianToJulianDateConverterApiCall',
	#superclass : 'USAJulianGregorianDateConverterApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAGregorianToJulianDateConverterApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'juliandate'.

]
