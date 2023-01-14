"
USASunData

	data from USACompleteSunAndMoonDataForOneDayApiCall

	sunriseUtc - sun rise date/time
	sunsetUtc - sun set date/time
	upperTransitUtc - sun transit date/time
	beginCivilTwilightUtc - begin civil twilight date/time
	endCivilTwilightUtc - end civil twilight date/time

"
Class {
	#name : 'USASunData',
	#superclass : 'USAReplyData',
	#instVars : [
		'sunriseUtc',
		'sunsetUtc',
		'beginCivilTwilightUtc',
		'upperTransitUtc',
		'endCivilTwilightUtc'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USASunData >> beginCivilTwilight [
	"Answer the local time of beginCivilTwilight."

	^beginCivilTwilightUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USASunData >> beginCivilTwilightUtc [
	"Answer the time of beginCivilTwilight."

	^beginCivilTwilightUtc.

]

{ #category : 'Not categorized' }
USASunData >> data: aDictionary [
	"Set our values from the dictionary."
	| anArray dateMilliseconds |

	dateMilliseconds := (self dateFromDictionary: aDictionary) asMilliseconds.
	anArray := aDictionary at: 'sundata' ifAbsent: [Array new].
	anArray do: [:dic | | key timeString dateAndTimeMilliseconds dateAndTime |
		key := dic at: 'phen' ifAbsent: [''].
		timeString := dic at: 'time' ifAbsent: [''].
		dateAndTimeMilliseconds := dateMilliseconds + ((USAUT1Time fromUSAString: timeString) asMilliseconds).
		dateAndTime := DateAndTime fromMilliseconds: dateAndTimeMilliseconds offset: Duration zero.
		(key = 'Begin Civil Twilight') ifTrue: [beginCivilTwilightUtc := dateAndTime].
		(key = 'End Civil Twilight') ifTrue: [endCivilTwilightUtc := dateAndTime].
		(key = 'Rise') ifTrue: [sunriseUtc := dateAndTime].
		(key = 'Set') ifTrue: [sunsetUtc := dateAndTime].
		(key = 'Upper Transit') ifTrue: [upperTransitUtc := dateAndTime].
	].

]

{ #category : 'Not categorized' }
USASunData >> dayLength [
	"Answer the length of day light (a duration)."

	^sunsetUtc - sunriseUtc.

]

{ #category : 'Not categorized' }
USASunData >> endCivilTwilight [
	"Answer the local time of endCivilTwilight."

	^endCivilTwilightUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USASunData >> endCivilTwilightUtc [
	"Answer the time of endCivilTwilight."

	^endCivilTwilightUtc.

]

{ #category : 'Not categorized' }
USASunData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	(indents > 0) ifTrue: [aStream cr; tab].
	aStream nextPutAll: 'Begin Civil Twilight: '.
	self beginCivilTwilight printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'End Civil Twilight: '.
	self endCivilTwilight printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Sunrise: '.
	self sunrise printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Sunset: '.
	self sunset printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Day Length: '.
	self dayLength printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Upper Transit: '.
	self upperTransit printOn: aStream.

]

{ #category : 'Not categorized' }
USASunData >> sunrise [
	"Answer the local time of sunrise."

	^sunriseUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USASunData >> sunriseUtc [
	"Answer the time of sunrise."

	^sunriseUtc.

]

{ #category : 'Not categorized' }
USASunData >> sunset [
	"Answer the local time of sunset."

	^sunsetUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USASunData >> sunsetUtc [
	"Answer the time of sunset."

	^sunsetUtc.

]

{ #category : 'Not categorized' }
USASunData >> upperTransit [
	"Answer the local time of upperTransit."

	^upperTransitUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USASunData >> upperTransitUtc [
	"Answer the time of upperTransit."

	^upperTransitUtc.

]
