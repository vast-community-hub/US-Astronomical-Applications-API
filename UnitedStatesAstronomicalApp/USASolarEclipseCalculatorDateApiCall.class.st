"
""Solar Eclipse Calculator"" see: https://aa.usno.navy.mil/data/api#soleclipse

	This data service provides local circumstances for solar eclipses,
	and also provides a means for determining dates and types of eclipses in a given year.

	For the local circumstances, data will be provided from 2017 through 2024.
	For dates outside of this range, see MICA at: https://aa.usno.navy.mil/software/mica_info

	This service requires a location and date, and may include height.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/SolarEclipses

	For a list of eclipses in a selected year, data will be provided for 1800 through 2050.

USASolarEclipseCalculatorDateApiCall example:

	| us |
	us := USASolarEclipseCalculatorDateApiCall new.
	us getLatitudeAndLongitudeParmFromInternetGuess.
	us dateParm: '2017-8-21'.
	us heightParm: 15.
	us buildTheUrl; callTheApi.
	us inspect.

"
Class {
	#name : 'USASolarEclipseCalculatorDateApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#instVars : [
		'duration',
		'localData'
	],
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'eclipses/solar/date'.

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> beginTime [
	"Answer the time the Eclipse begins."
	| index |

	index := localData findFirst: [:e | '*Begins*' match: e phenomenon].
	^(index > 0) ifTrue: [(localData at: index) time] ifFalse: [].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> callTheApi [
	"Call the api with our url."
	| aDate aTime |

	super callTheApi.
	aDate := self class dateFromDictionary: self properties.
	duration := Duration fromUSAString: (self properties at: 'duration' ifAbsent: ['']).
	localData := (self properties at: 'local_data' ifAbsent: [Array new]) collect: [:ld | USASolarEclipseLocalData data: ld].
	aTime := self beginTime.
	(aDate notNil & aTime notNil) ifTrue: [dateAndTimeUtc := (DateAndTime date: aDate time: aTime) asUTC].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> day [
	"Answer the value of description."

	^(self properties at: 'day' ifAbsent: ['']) asNumber.

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> delta_t [
	"Answer the value of delta_t."

	^self properties at: 'delta_t' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> deltaT [
	"Answer the value of deltaT."

	^self class numberFromString: self delta_t.

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> description [
	"Answer the value of description."

	^self properties at: 'description' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> endTime [
	"Answer the time the Eclipse ends."
	| index |

	index := localData findFirst: [:e | '*Ends*' match: e phenomenon].
	^(index > 0) ifTrue: [(localData at: index) time] ifFalse: [].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> event [
	"Answer the value of event."

	^self properties at: 'event' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> localData [
	"Answer the value of localData."

	^localData.

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> magnitude [
	"Answer the value of magnitude."

	^self properties at: 'magnitude' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> maximumTime [
	"Answer the time the Eclipse is at Maximum."
	| index |

	index := localData findFirst: [:e | '*Maximum*' match: e phenomenon].
	^(index > 0) ifTrue: [(localData at: index) time] ifFalse: [].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> obscuration [
	"Answer the value of obscuration."

	^self properties at: 'obscuration' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorDateApiCall >> printOn: aStream [
	"Print our data on the stream."

	super printOn: aStream.
	aStream nextPutAll: 'Description: '; nextPutAll: self description; cr.
	aStream nextPutAll: 'Event: '; nextPutAll: self event; cr.
	aStream nextPutAll: 'DeltaT: '; nextPutAll: self delta_t; cr.
	aStream nextPutAll: 'Day: '; nextPutAll: self day printString; cr.
	aStream nextPutAll: 'Magnitude: '; nextPutAll: self magnitude printString; cr.
	aStream nextPutAll: 'Obscuration: '; nextPutAll: self obscuration; cr.
	aStream nextPutAll: 'Local Data:'; cr; tab.
	self localData do: [:ld | ld printOn: aStream] separatedBy: [aStream tab].

]
