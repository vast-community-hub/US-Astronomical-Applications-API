"
""Complete Sun and Moon Data for One Day"" see: https://aa.usno.navy.mil/data/api#rstt

	This service supplies information about the sun and the moon like rise and set times for a given day.

	In this USACompleteSunAndMoonDataForOneDayApiCall example the date is supplied
	along with the latitude and longitude location guess from another internet server.  You can supply
	your own if you know it.

	| us |
	us := USACompleteSunAndMoonDataForOneDayApiCall new.
	us dateParm: Date today.
	us getLatitudeAndLongitudeParmFromInternetGuess.
	us buildTheUrl; callTheApi.
	us sunData inspect.
	us moonData inspect.
	us inspect.

"
Class {
	#name : 'USACompleteSunAndMoonDataForOneDayApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#instVars : [
		'closestPhase',
		'moonData',
		'sunData'
	],
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'rstt/oneday'.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	dateAndTimeUtc := self class dateAndTimeFromDictionary: self data.
	closestPhase := self getClosestPhase.
	moonData := self getMoonData.
	sunData := self getSunData.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> closestPhase [
	"Answer the moon phase data for the closest phase."

	^closestPhase.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> currentPhase [
	"Answer the moon phase data for the current phase."

	^self data at: 'curphase' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> data [
	"Answer the dictionary with the data."

	^self properties at: 'data' ifAbsent: [Dictionary new].

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> date [
	"Answer the date from the data."

	^dateAndTimeUtc date.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> fracillum [
	"Answer the fracillum."

	^self data at: 'fracillum' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> getClosestPhase [
	"Answer the moon phase data for the closest phase."
	| aPhase |

	aPhase := self data at: 'closestphase' ifAbsent: [].
	^aPhase notNil ifTrue: [USAMoonPhaseData data: aPhase] ifFalse: [].

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> getMoonData [
	"Answer the data about the moon."

	^USAMoonData data: self data.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> getSunData [
	"Answer the data about the sun."

	^USASunData data: self data.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> moonData [
	"Answer the data about the moon."

	^moonData.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> printOn: aStream [
	"Print our data on the stream."

	super printOn: aStream.
	aStream nextPutAll: 'Date: '.
	self date printOn: aStream.
	aStream cr; nextPutAll: 'Closest '.
	self closestPhase printOn: aStream.
	aStream cr; nextPutAll: 'Current Phase: '; nextPutAll: self currentPhase; cr.
	aStream nextPutAll: 'Sun Data: '.
	self sunData printOn: aStream.
	aStream cr; nextPutAll: 'Moon Data: '.
	self moonData printOn: aStream.
	aStream cr; nextPutAll: 'Fracillum: '.
	self fracillum printOn: aStream.

]

{ #category : 'Not categorized' }
USACompleteSunAndMoonDataForOneDayApiCall >> sunData [
	"Answer the data about the sun."

	^sunData.

]
