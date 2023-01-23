"
USAJulianGregorianDateConverterApiCall is the super class of USAGregorianToJulianDateConverterApiCall
and USAJulianToGregorianDateConverterApiCall, as such doesn't get instantiated.
See: https://aa.usno.navy.mil/data/api#jdconv

	This data service converts dates between the Julian/Gregorian calendar and Julian date.
	Data will be provided for the years 4713 B.C. through A.D. 9999, or Julian dates of 0 through 5373484.5.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/JulianDate
"
Class {
	#name : 'USAJulianGregorianDateConverterApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#instVars : [
		'date',
		'time',
		'julianDate',
		'era',
		'dayOfWeek'
	],
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAJulianGregorianDateConverterApiCall >> callTheApi [
	"Call the api with our url."
	| data |

	super callTheApi.
	data := self data.
	date := self class dateFromDictionary: data.
	time := self class timeFromDictionary: data.
	julianDate := Float readFrom: (data at: 'jd' ifAbsent: []) ifFail: [].
	era := data at: 'era' ifAbsent: [''].
	dayOfWeek := data at: 'dayofweek' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USAJulianGregorianDateConverterApiCall >> data [
	"Answer the dictionary with the data."

	^(self resultTable at: 'data' ifAbsent: [Array new]) at: 1 ifAbsent: [Dictionary new].

]

{ #category : 'Not categorized' }
USAJulianGregorianDateConverterApiCall >> printOn: aStream [
	"Print our data on the stream."

	super printOn: aStream.
	aStream nextPutAll: 'Date: '.
	date printOn: aStream.
	aStream cr; nextPutAll: 'Time: '.
	time printOn: aStream.
	aStream cr; nextPutAll: 'Julian Date: '.
	julianDate printOn: aStream.
	aStream cr; nextPutAll: 'ERA: '; nextPutAll: era.
	aStream cr; nextPutAll: 'Day Of Week: '; nextPutAll: dayOfWeek.

]
