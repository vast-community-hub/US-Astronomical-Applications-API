"
USAMoonData

	data from USACompleteSunAndMoonDataForOneDayApiCall

	moonriseUtc - moon rise date/time
	moonsetUtc - moon set date/time
	upperTransitUtc - moon transit date/time

"
Class {
	#name : 'USAMoonData',
	#superclass : 'USAReplyData',
	#instVars : [
		'moonriseUtc',
		'moonsetUtc',
		'upperTransitUtc'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAMoonData >> data: aDictionary [
	"Set our values from the dictionary."
	| theDate anArray dateMilliseconds |

	theDate := self dateFromDictionary: aDictionary.
	theDate notNil ifTrue: [
		dateMilliseconds := theDate asMilliseconds.
		anArray := aDictionary at: 'moondata' ifAbsent: [Array new].
		anArray do: [:dic | | key timeString dateAndTimeMilliseconds dateAndTime |
			key := dic at: 'phen' ifAbsent: [''].
			timeString := dic at: 'time' ifAbsent: [''].
			dateAndTimeMilliseconds := dateMilliseconds + ((USAUT1Time fromUSAString: timeString) asMilliseconds).
			dateAndTime := DateAndTime fromMilliseconds: dateAndTimeMilliseconds offset: Duration zero.
			(key = 'Rise') ifTrue: [moonriseUtc := dateAndTime].
			(key = 'Set') ifTrue: [moonsetUtc := dateAndTime].
			(key = 'Upper Transit') ifTrue: [upperTransitUtc := dateAndTime].
		].
	].

]

{ #category : 'Not categorized' }
USAMoonData >> moonLength [
	"Answer the of length of moon light (a duration)."

	^moonsetUtc - moonriseUtc.

]

{ #category : 'Not categorized' }
USAMoonData >> moonrise [
	"Answer the local time of moonrise."

	^moonriseUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USAMoonData >> moonriseUtc [
	"Answer the time of moonrise."

	^moonriseUtc.

]

{ #category : 'Not categorized' }
USAMoonData >> moonset [
	"Answer the local time of moonset."

	^moonsetUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USAMoonData >> moonsetUtc [
	"Answer the time of moonset."

	^moonsetUtc.

]

{ #category : 'Not categorized' }
USAMoonData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	(indents > 0) ifTrue: [aStream cr; tab].
	aStream nextPutAll: 'Rise: '.
	self moonrise printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Set: '.
	self moonset printOn: aStream.
	aStream cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Upper Transit: '.
	self upperTransit printOn: aStream.

]

{ #category : 'Not categorized' }
USAMoonData >> upperTransit [
	"Answer the local time of upperTransit."

	^upperTransitUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
USAMoonData >> upperTransitUtc [
	"Answer the time of upperTransit."

	^upperTransitUtc.

]
