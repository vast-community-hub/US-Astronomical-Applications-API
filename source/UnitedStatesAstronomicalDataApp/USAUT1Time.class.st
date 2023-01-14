Class {
	#name : 'USAUT1Time',
	#superclass : 'Duration',
	#pools : [
		'NlsGlobals'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAUT1Time class >> days: aNumber [
	"We don't use the #days: part of Duration (Our super class)."

	self doesNotUnderstand: (Message selector: #days: arguments: (Array with: aNumber)).

]

{ #category : 'Not categorized' }
USAUT1Time class >> days: days hours: hours minutes: minutes seconds: seconds [
	"We don't use the #days:hours:minutes:seconds: part of Duration (Our super class)."

	self doesNotUnderstand: (Message selector: #days:hours:minutes:seconds: arguments: (Array with: days with: hours with: minutes with: seconds)).

]

{ #category : 'Not categorized' }
USAUT1Time class >> days: days hours: hours minutes: minutes seconds: seconds milliseconds: milliseconds [
	"We don't use the #days:hours:minutes:seconds: part of Duration (Our super class)."

	self doesNotUnderstand: (Message selector: #days:hours:minutes:seconds:milliseconds: arguments: (Array with: days with: hours with: minutes with: seconds with: milliseconds)).

]

{ #category : 'USA Extension' }
USAUT1Time class >> fromUSAString: aString [
	"Create a new instance and set its values from those in the string."
	| timeParts hours minutes seconds sString sParts fString totalSeconds |

	timeParts := aString subStrings: $:.
	hours := (timeParts at: 1 ifAbsent: ['0']) asNumber.
	minutes := (timeParts at: 2 ifAbsent: ['0']) asNumber.
	sString := timeParts at: 3 ifAbsent: ['0.0'].

	sParts := sString subStrings: $..
	seconds := (sParts at: 1 ifAbsent: ['0']) asNumber.
	fString := sParts at: 2 ifAbsent: ['0'].
	[fString size < 3] whileTrue: [fString := fString, '0'].
	^(fString size > 3) ifTrue: [
		[fString size < 6] whileTrue: [fString := fString, '0'].
		totalSeconds := ((hours * SecondsPerHour) + (minutes * SecondsPerMinute) + seconds) asInteger.
		self totalSeconds: totalSeconds microseconds: fString asNumber.
	] ifFalse: [
		Time new hours: hours minutes: minutes seconds: seconds milliseconds: fString asNumber.
	].

]

{ #category : 'Not categorized' }
USAUT1Time class >> initializeAfterLoad [

]

{ #category : 'Not categorized' }
USAUT1Time class >> weeks: aNumber [
	"We don't use the #weeks: part of Duration (Our super class)."

	self doesNotUnderstand: (Message selector: #weeks: arguments: (Array with: aNumber)).

]

{ #category : 'Not categorized' }
USAUT1Time class >> zero [
	"Answer a time of 0."

	^self totalSeconds: 0 microseconds: 0.

]

{ #category : 'Not categorized' }
USAUT1Time >> days [
	"We don't use the #days part of Duration (Our super class)."

	self doesNotUnderstand: (Message selector: #days arguments: #()).

]

{ #category : 'Not categorized' }
USAUT1Time >> isHighResolutionTime [
	"Answer true is we are accurate to microseconds."

	^(microseconds - (self asMilliseconds * MicrosecondsPerMillisecond)) ~= 0.

]

{ #category : 'Not categorized' }
USAUT1Time >> printOn: aStream [
	"Synopsis
		Write a textual description of the receiver to @aStream.
	 Definition: <Object>
		The string of characters that would be the result of sending the message #printString to the
		receiver is written to target. The characters appear on the stream as if each character was, in
		sequence, written to the stream using the message #nextPut:.
	 Refinement: <Duration>
		Write a textual description of the receiver that is formatted as
		 [-]HH:MM:SS[.S] where

			- is a minus sign if the receiver represents a length of time going from the future into
			the past,
			HH is the number of complete hours with leading zeros to fill two places,
			MM is the number of complete minutes with leading zeros to fill two places,
			SS is. the number of complete seconds with leading zeros to fill two places, and
			.S is the fractional part of the number of seconds, if any.
	 Parameters:
		@aStream <puttableStream> uncaptured
	 Return Values
		Unspecified
	 Errors
		None
	 Implementation Notes
		ANSI specifies the #printString protocol, not the #printOn: protocol for
		this class.  However, since VAST implements a more general #printString
		in terms of #printOn:, the protocol has been applied here instead.	"

	self negative
		ifTrue: [
			aStream nextPut: $-.	"$NON-NLS$"
			^ self negated printOn: aStream ].
	aStream
		nextPutAll: (self hours printStringRadix: 10 padTo: 2);
		nextPut: $:;
		nextPutAll: (self minutes printStringRadix: 10 padTo: 2);
		nextPut: $:;
		nextPutAll: (self seconds printStringRadix: 10 padTo: 2).
	self microseconds > 0 ifTrue: [
		aStream
			nextPut: $.;
			nextPutAll: ((self microseconds printStringRadix: 10 padTo: 6) trimRight: [ :ea | ea = $0 ]) ]
]
