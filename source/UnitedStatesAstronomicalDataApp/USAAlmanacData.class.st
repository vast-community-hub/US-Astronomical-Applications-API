"
USAAlmanacData

-	Almanac data from a USACelestialNavigationDataForAssumedPositionAndTimeApiCall.
-
	dec - the declination in decimal degrees
	gha - the Greenwich Hour Angle in decimal degrees
	hc - the computed geocentric altitude in decimal degrees
	zn - the computed azimuth in decimal degrees

"
Class {
	#name : 'USAAlmanacData',
	#superclass : 'USAReplyData',
	#instVars : [
		'dec',
		'gha',
		'hc',
		'zn'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAAlmanacData >> data: aDictionary [
	"Set our values."

	dec := aDictionary at: 'dec' ifAbsent: [].
	gha := aDictionary at: 'gha' ifAbsent: [].
	hc := aDictionary at: 'hc' ifAbsent: [].
	zn := aDictionary at: 'zn' ifAbsent: [].

]

{ #category : 'Not categorized' }
USAAlmanacData >> dec [
	"Answer our dec value."

	^dec.

]

{ #category : 'Not categorized' }
USAAlmanacData >> gha [
	"Answer our gha value."

	^gha.

]

{ #category : 'Not categorized' }
USAAlmanacData >> hc [
	"Answer our hc value."

	^hc.

]

{ #category : 'Not categorized' }
USAAlmanacData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'dec: '; nextPutAll: dec printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'gha: '; nextPutAll: gha printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'hc: '; nextPutAll: hc printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'zn: '; nextPutAll: zn printString; cr.

]

{ #category : 'Not categorized' }
USAAlmanacData >> zn [
	"Answer our zn value."

	^zn.

]
