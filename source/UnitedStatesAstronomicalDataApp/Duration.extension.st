Extension {
	#name : 'Duration'
}

{ #category : '*UnitedStatesAstronomicalDataApp',
 #vaCategories : ['USA Extension'] }
Duration class >> fromUSAString: aString [
	"Create a new instance and set its values.  None of these durations should have days but we try to deal if they do.
		The version with letters could be out of order but for now we don't handle that."
	| days parts hours minutes sString seconds sParts fString totalSeconds uSeconds aStream |

	^aString notEmpty ifTrue: [
		(aString includes: $:) ifTrue: [		"If true the string looks like 'h:m:s.f' (1:2:3.4)."
			parts := (aString subStrings: $:) asOrderedCollection.
		] ifFalse: [										"If false the string should look like '2h 3m 4.5s'."
			aStream := WriteStream on: (String new: aString size).
			aString do: [:c | ('0123456789-+.' includes: c) ifTrue: [aStream nextPut: c]].		"remove the letters."
			parts := aStream contents subStrings asOrderedCollection.
		].
		[parts size < 4] whileTrue: [parts addFirst: '0'].

		days := (parts at: 1 ifAbsent: ['0']) asNumber.
		hours := (parts at: 2 ifAbsent: ['0']) asNumber.
		minutes := (parts at: 3 ifAbsent: ['0']) asNumber.
		sString	:= parts at: 4 ifAbsent: ['0.0'].
		sParts := sString subStrings: $..
		seconds := (sParts at: 1 ifAbsent: ['0']) asNumber.
		fString := sParts at: 2 ifAbsent: ['0'].
		[fString size < 6] whileTrue: [fString := fString, '0'].
		uSeconds := fString asNumber.

		totalSeconds := ((days * SecondsPerDay) + (hours * SecondsPerHour) + (minutes * SecondsPerMinute) + seconds) asInteger.
		self totalSeconds: totalSeconds microseconds: uSeconds.
	] ifFalse: [].

]

{ #category : '*UnitedStatesAstronomicalDataApp',
 #vaCategories : ['Ksc Extensions'] }
Duration >> asFloatSeconds [
	"Answer a Float of our totalSeconds and microseconds."

	^(totalSeconds asFloat + (microseconds / 1000000)).

]
