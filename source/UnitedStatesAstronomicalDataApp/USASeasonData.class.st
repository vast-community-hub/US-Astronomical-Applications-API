"
USASeasonData

	data from USAEarthSeasonsApiCall

	Holds the date and a description of the event.
	Answers a symbol that describe the season.

"
Class {
	#name : 'USASeasonData',
	#superclass : 'USAReplyData',
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USASeasonData >> data: aDictionary [
	"Set our values from the dictionary."

	dateAndTimeUtc := self dateAndTimeFromDictionary: aDictionary.
	value := aDictionary at: 'phenom' ifAbsent: [].

]

{ #category : 'Not categorized' }
USASeasonData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream
		nextPutAll: 'Season: '; nextPutAll: value; nextPutAll: ' (#'; nextPutAll: self seasonSymbol; nextPutAll: ')'; cr; tab.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'DateAndTime: '.
	self dateAndTime printOn: aStream.

]

{ #category : 'Not categorized' }
USASeasonData >> season [
	"Answer the season of the year."

	^value.

]

{ #category : 'Not categorized' }
USASeasonData >> seasonSymbol [
	"Answer a symbol that describes the season of the year."

	^(value copyWithout: Space) asSymbol.

]
