"
USAObservanceData is the super class of USAChristianObservanceData, USAIslamicObservanceData
and USAJewishObservanceData, as such doesn't get instantiated.

	date - the date of the observance
	value - the observance
	observanceShortName - a short name for the observance
-
- See each class comment for more information.

"
Class {
	#name : 'USAObservanceData',
	#superclass : 'USAReplyData',
	#instVars : [
		'observanceShortName'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAObservanceData >> data: aDictionary [
	"Set our values from the dictionary."

	date := self dateFromDictionary: aDictionary.
	value := aDictionary at: 'observance' ifAbsent: [].

]

{ #category : 'Not categorized' }
USAObservanceData >> observanceShortName [
	"Answer the short name of the observance."

	^observanceShortName.

]

{ #category : 'Not categorized' }
USAObservanceData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'Observance: '; nextPutAll: self observanceShortName; nextPutAll: ' ('; nextPutAll: value; nextPutAll: ')'; cr; tab.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Date: '.
	self date printOn: aStream.

]
