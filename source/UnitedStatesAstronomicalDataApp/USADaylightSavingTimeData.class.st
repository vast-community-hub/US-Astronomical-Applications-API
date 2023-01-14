"
USADaylightSavingTimeData

-	data from a USADaylightSavingTimeApiCall
-
	Holds the date and a description of the event.
	Has methods that return when daylight saving time begins and ends

"
Class {
	#name : 'USADaylightSavingTimeData',
	#superclass : 'USAReplyData',
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USADaylightSavingTimeData >> data: aDictionary [
	"Set the values."

	date := self dateFromDictionary: aDictionary.
	value := aDictionary at: 'event' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USADaylightSavingTimeData >> ends [
	"Answer true if this is the end of daylight savings time."

	^('*Ends*' match: self event).

]

{ #category : 'Not categorized' }
USADaylightSavingTimeData >> event [
	"Answer our event."

	^value.

]

{ #category : 'Not categorized' }
USADaylightSavingTimeData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: (self starts ifTrue: ['Starts: '] ifFalse: ['Ends: ']); nextPutAll: date printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Event: '; nextPutAll: self event printString; cr.

]

{ #category : 'Not categorized' }
USADaylightSavingTimeData >> starts [
	"Answer true if this is the start (beginning) of daylight savings time."

	^('*Begins*' match: self event).

]
