"
USASolarEclipseLocalData

	data from USASolarEclipseCalculatorDateApiCall

	time - time (given in UT1)
	altitude - the altiude of the Sun during this event
	azimuth - the azimuth of the Sun during this event
	day - the day of the month (some eclipses occur over two days in UT1)
	phenomenon - the name of the eclipse event
	positionAngle - the position angle of the event, not given for
	durationOfTotality - the duration of eclipse totality at this location, for locations where total eclipse occurs only
	vertexAngle - the vertex angle of the event, not given for maximum eclipse or sunrise/sunset

"
Class {
	#name : 'USASolarEclipseLocalData',
	#superclass : 'USAReplyData',
	#instVars : [
		'altitude',
		'azimuth',
		'day',
		'phenomenon',
		'positionAngle',
		'durationOfTotality',
		'vertexAngle'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> altitude [
	"Answer the value of altitude."

	^altitude.

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> azimuth [
	"Answer the value of azimuth."

	^azimuth.

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> data: aDictionary [
	"Set the values."

	altitude := self numberFromString: (aDictionary at: 'altitude' ifAbsent: ['0']).
	azimuth := self numberFromString: (aDictionary at: 'azimuth' ifAbsent: ['0']).
	day := self numberFromString: (aDictionary at: 'day' ifAbsent: ['0']).
	phenomenon := aDictionary at: 'phenomenon' ifAbsent: [''].
	positionAngle := self numberFromString: (aDictionary at: 'position_angle' ifAbsent: ['0']).
	time := self timeFromDictionary: aDictionary.
	durationOfTotality := Duration fromUSAString: (aDictionary at: 'duration_of_totality' ifAbsent: ['']).
	vertexAngle := self numberFromString: (aDictionary at: 'vertex_angle' ifAbsent: ['0']).

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> day [
	"Answer the value of day."

	^day.

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> durationOfTotality [
	"Answer the value of durationOfTotality."

	^durationOfTotality.

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> phenomenon [
	"Answer the value of phenomenon."

	^phenomenon.

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> positionAngle [
	"Answer the value of positionAngle."

	^positionAngle.

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'Altitude: '; nextPutAll: altitude printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Azimuth: '; nextPutAll: azimuth printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Day: '; nextPutAll: day printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Phenomenon: '; nextPutAll: phenomenon; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Position Angle: '; nextPutAll: positionAngle printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Time: '.
	time printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'DurationOfTotality: '.
	(durationOfTotality ~= Duration zero) ifTrue: [durationOfTotality printOn: aStream].
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Vertex Angle: '; nextPutAll: vertexAngle printString; cr; cr.

]

{ #category : 'Not categorized' }
USASolarEclipseLocalData >> vertexAngle [
	"Answer the value of vertexAngle."

	^vertexAngle.

]
