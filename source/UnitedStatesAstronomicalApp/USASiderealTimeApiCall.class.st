"
""Sidereal Time"" see: https://aa.usno.navy.mil/data/api#sidtime

	This data service provides the Greenwich mean and apparent sidereal time,
	local mean and apparent sidereal time, and the Equation of the Equinoxes
	for date(s) and time(s) specified in UT1.

	Data will be provided for the years 1800 through 2050.

	This service requires a location, a date, and a time (in UT1).
	Time interval information is optional, if none is provided, then a single iteration will be returned.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/siderealtime

USASiderealTimeApiCall example:

	| us |
	us := USASiderealTimeApiCall new.
	us dateParm: '2020-03-04'.
	us latitudeParm: 41.89 longitudeParm: 12.48.
	us minutesTimeIntervalParm: 5 iterations: 90.
	us timeParm: '21:00:00'.
	us buildTheUrl; callTheApi.
	us inspect.

"
Class {
	#name : 'USASiderealTimeApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USASiderealTimeApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'siderealtime'.

]

{ #category : 'Not categorized' }
USASiderealTimeApiCall class >> timeKey [
	"Answer the key used to get the time from the dictionary."

	^'ut1time'.

]

{ #category : 'Not categorized' }
USASiderealTimeApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	self getSiderealTimeData.

]

{ #category : 'Not categorized' }
USASiderealTimeApiCall >> getSiderealTimeData [
	"Get the Sidereal Time data."
	| theData |

	theData := self properties at: 'data' ifAbsent: [Array new].
	values := theData collect: [:d | USASiderealTimeData data: d].

]

{ #category : 'Not categorized' }
USASiderealTimeApiCall >> printOn: aStream [
	"Print our data on the stream."
	| theSiderealTimes |

	super printOn: aStream.
	theSiderealTimes := self siderealTimes.
	theSiderealTimes notEmpty ifTrue: [
		aStream nextPutAll: 'SiderealTimes:'; cr.
		theSiderealTimes do: [:s |
			aStream tab.
			s printOn: aStream.
			aStream cr; cr.
		].
	].

]

{ #category : 'Not categorized' }
USASiderealTimeApiCall >> siderealTimes [
	"Answer the Sidereal Times Data."

	^values ifNil: [#()].

]
