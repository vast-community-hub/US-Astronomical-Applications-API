"
""Daylight Saving Time"" see: https://aa.usno.navy.mil/data/api#dst_api

	This data service calculates the start and end dates for U.S.
	Daylight Saving Time for the years 1967 through 9999
	(assuming future years maintain the same rules for start and end dates).
	More information about this data service may be found at: https://aa.usno.navy.mil/data/daylight_time

USADaylightSavingTimeApiCall example:

	| us |
	us := USADaylightSavingTimeApiCall new.
	us yearParm: 1990.
	us buildTheUrl; callTheApi.
	us inspect.

	| us |
	us := USADaylightSavingTimeApiCall new.
	us yearParm: Date today year.
	us buildTheUrl; callTheApi.
	us inspect.

"
Class {
	#name : 'USADaylightSavingTimeApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USADaylightSavingTimeApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'daylightsaving'.

]

{ #category : 'Not categorized' }
USADaylightSavingTimeApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	self getDaylightSavingsTimeData.

]

{ #category : 'Not categorized' }
USADaylightSavingTimeApiCall >> events [
	"Answer the Daylight Saving Time Data."

	^values ifNil: [#()].

]

{ #category : 'Not categorized' }
USADaylightSavingTimeApiCall >> getDaylightSavingsTimeData [
	"Get the Daylight Saving Time Data."
	| events |

	events := self resultTable at: 'data' ifAbsent: [Array new].
	values := events collect: [:e | USADaylightSavingTimeData data: e].

]

{ #category : 'Not categorized' }
USADaylightSavingTimeApiCall >> printOn: aStream [
	"Print our data on the stream."
	| theEvents |

	super printOn: aStream.
	theEvents := self events.
	theEvents notEmpty ifTrue: [
		aStream nextPutAll: 'Events:'; cr.
		theEvents do: [:e |
			aStream tab.
			e printOn: aStream.
			aStream cr.
		].
	].

]
