"
USAEclipseInYearData

	data returned by USASolarEclipseCalculatorDateApiCall

	Holds the date and a description of the event.

"
Class {
	#name : 'USAEclipseInYearData',
	#superclass : 'USAReplyData',
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAEclipseInYearData >> data: aDictionary [
	"Set our values from the dictionary."

	date := self dateFromDictionary: aDictionary.
	value := aDictionary at: 'event' ifAbsent: [].

]

{ #category : 'Not categorized' }
USAEclipseInYearData >> date [
	"Answer the local date of this data."

	^date.

]

{ #category : 'Not categorized' }
USAEclipseInYearData >> event [
	"Answer the short description of the event."

	^value.

]

{ #category : 'Not categorized' }
USAEclipseInYearData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'Eclipse: '; nextPutAll: value; cr; tab.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Date: '.
	self date printOn: aStream.

]
