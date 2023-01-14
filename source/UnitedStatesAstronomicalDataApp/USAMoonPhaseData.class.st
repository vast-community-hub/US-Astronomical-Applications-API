"
USAMoonPhaseData

	data from USACompleteSunAndMoonDataForOneDayApiCall

	Holds the date and a description of the event.
	Answers symbols that describe the phase of the moon.

"
Class {
	#name : 'USAMoonPhaseData',
	#superclass : 'USAReplyData',
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAMoonPhaseData >> data: aDictionary [
	"Create a new instance and set its values from the dictionary."

	dateAndTimeUtc := self dateAndTimeFromDictionary: aDictionary.
	value := aDictionary at: 'phase' ifAbsent: [].

]

{ #category : 'Not categorized' }
USAMoonPhaseData >> isFirstQuarter [
	"Answer true if we are a First Quarter Moon."

	^self phaseSymbol = #FirstQuarter.

]

{ #category : 'Not categorized' }
USAMoonPhaseData >> isFullMoon [
	"Answer true if we are a Full Moon."

	^self phaseSymbol = #FullMoon.

]

{ #category : 'Not categorized' }
USAMoonPhaseData >> isLastQuarter [
	"Answer true if we are a Last Quarter Moon."

	^self phaseSymbol = #LastQuarter.

]

{ #category : 'Not categorized' }
USAMoonPhaseData >> isNewMoon [
	"Answer true if we are a New Moon."

	^self phaseSymbol = #NewMoon.

]

{ #category : 'Not categorized' }
USAMoonPhaseData >> phase [
	"Answer the phase of the moon."

	^value.

]

{ #category : 'Not categorized' }
USAMoonPhaseData >> phaseSymbol [
	"Answer a symbol that describes the phase of the moon."

	^(self phase copyWithout: Space) asSymbol.

]

{ #category : 'Not categorized' }
USAMoonPhaseData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'Phase: '; nextPutAll: self phase; nextPutAll: ' (#'; nextPutAll: self phaseSymbol; nextPutAll: ')'; cr; tab.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'DateAndTime: '.
	self dateAndTime printOn: aStream.

]
