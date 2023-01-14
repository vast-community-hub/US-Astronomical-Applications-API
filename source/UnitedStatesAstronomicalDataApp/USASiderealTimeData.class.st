"
USASiderealTimeData

-	data returned from USASiderealTimeApiCall
-
	eqofeq - equation of the equinoxes (seconds offset)
	gast - Greenwich apparent sidereal time
	gmst - Greenwich mean sidereal time
	last - local apparent sidereal time
	lmst - local mean sidereal time
	data - a dictionary with all the data
	ut1Time -  time in UT1
"
Class {
	#name : 'USASiderealTimeData',
	#superclass : 'USAReplyData',
	#instVars : [
		'eqofeq',
		'gast',
		'gmst',
		'last',
		'lmst',
		'data',
		'ut1Time'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USASiderealTimeData >> data: aDictionary [
	"Set our values from the dictionary.
		Note: USAUT1Time will return an instance of Time if only milliseconds are needed."

	data := aDictionary.
	date := self dateFromDictionary: data.
	eqofeq := self numberFromString: (data at: 'eqofeq' ifAbsent: ['']).

	ut1Time := USAUT1Time fromUSAString: self ut1String.
	gast := USAUT1Time fromUSAString: self gastString.
	gmst := USAUT1Time fromUSAString: self gmstString.
	last := USAUT1Time fromUSAString: self lastString.
	lmst := USAUT1Time fromUSAString: self lmstString.

]

{ #category : 'Not categorized' }
USASiderealTimeData >> eqofeq [
	"Answer eqofeq."

	^eqofeq.

]

{ #category : 'Not categorized' }
USASiderealTimeData >> gast [
	"Answer gast.  Stored as a Duration with microseconds."

	^gast.

]

{ #category : 'Not categorized' }
USASiderealTimeData >> gastString [
	"Answer the gast string from the data.  A UT1 time with fractions of a second that can be microseconds."

	^data at: 'gast' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASiderealTimeData >> gmst [
	"Answer gmst.  Stored as a Duration with microseconds."

	^gmst.

]

{ #category : 'Not categorized' }
USASiderealTimeData >> gmstString [
	"Answer the gmst string from the data.  A UT1 time with fractions of a second that can be microseconds."

	^data at: 'gmst' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASiderealTimeData >> last [
	"Answer last.  Stored as a Duration with microseconds."

	^last.

]

{ #category : 'Not categorized' }
USASiderealTimeData >> lastString [
	"Answer the last string from the data.  A UT1 time with fractions of a second that can be microseconds."

	^data at: 'last' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASiderealTimeData >> lmst [
	"Answer lmst.  Stored as a Duration with microseconds."

	^lmst.

]

{ #category : 'Not categorized' }
USASiderealTimeData >> lmstString [
	"Answer the lmst string from the data.  A UT1 time with fractions of a second that can be microseconds."

	^data at: 'lmst' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASiderealTimeData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'Date: '; nextPutAll: self date printString; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'UT1 time: '; nextPutAll: self ut1String;
		nextPutAll: ' ('; nextPutAll: self ut1Time printString; nextPutAll: ')'; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Greenwich mean sidereal time (gmst): '; nextPutAll: self gmstString;
		nextPutAll: ' ('; nextPutAll: self gmst printString; nextPutAll: ')'; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Greenwich apparent sidereal time (gast): '; nextPutAll: self gastString;
		nextPutAll: ' ('; nextPutAll: self gast printString; nextPutAll: ')'; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Local mean sidereal time (lmst): '; nextPutAll: self lmstString;
		nextPutAll: ' ('; nextPutAll: self lmst printString; nextPutAll: ')'; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Local apparent sidereal time (last): '; nextPutAll: self lastString;
		nextPutAll: ' ('; nextPutAll: self last printString; nextPutAll: ')'; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Equation of the equinoxes: '.
	eqofeq printOn: aStream.

]

{ #category : 'Not categorized' }
USASiderealTimeData >> ut1String [
	"Answer the ut1 string from the data.  A UT1 time with fractions of a second that can be microseconds."

	^data at: 'ut1time' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASiderealTimeData >> ut1Time [
	"Answer ut1time.  Stored as a Duration with microseconds."

	^ut1Time.

]
