"
USAAltitudeCorrectionsData

-	Altitude corrections data from a USACelestialNavigationDataForAssumedPositionAndTimeApiCall.
-
	isCorrected - boolean that indicates if altitude corrections are displayed
	pa - the parallax in altitude in decimal degrees
	refr - the atmospheric refraction in decimal degrees
	sd - the semidiameter in decimal degrees
	sum - the sum of the other three altitude corrections in decimal degrees

"
Class {
	#name : 'USAAltitudeCorrectionsData',
	#superclass : 'USAReplyData',
	#instVars : [
		'isCorrected',
		'pa',
		'refr',
		'sd',
		'sum'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAAltitudeCorrectionsData >> data: aDictionary [
	"Set our values."

	isCorrected := aDictionary at: 'isCorrected' ifAbsent: [].
	pa := aDictionary at: 'pa' ifAbsent: [].
	refr := aDictionary at: 'refr' ifAbsent: [].
	sd := aDictionary at: 'sd' ifAbsent: [].
	sum := aDictionary at: 'sum' ifAbsent: [].

]

{ #category : 'Not categorized' }
USAAltitudeCorrectionsData >> isCorrected [
	"Answer our isCorrected value."

	^isCorrected.

]

{ #category : 'Not categorized' }
USAAltitudeCorrectionsData >> pa [
	"Answer our pa value."

	^pa.

]

{ #category : 'Not categorized' }
USAAltitudeCorrectionsData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'Corrected: '; nextPutAll: isCorrected printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'pa: '; nextPutAll: pa printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'refr: '; nextPutAll: refr printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'sd: '; nextPutAll: sd printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'sum: '; nextPutAll: sum printString; cr.

]

{ #category : 'Not categorized' }
USAAltitudeCorrectionsData >> refr [
	"Answer our refr value."

	^refr.

]

{ #category : 'Not categorized' }
USAAltitudeCorrectionsData >> sd [
	"Answer our sd value."

	^sd.

]

{ #category : 'Not categorized' }
USAAltitudeCorrectionsData >> sum [
	"Answer our sum value."

	^sum.

]
