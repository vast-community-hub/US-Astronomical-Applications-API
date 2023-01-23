"
""Celestial Navigation Data for Assumed Position and Time"" see: https://aa.usno.navy.mil/data/api#celnav_api

	This data service provides all the astronomical information necessary to plot navigational lines
	of position from observations of the altitudes of celestial bodies.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/celnav

USACelestialNavigationDataForAssumedPositionAndTimeApiCall example:

	| us |
	us := USACelestialNavigationDataForAssumedPositionAndTimeApiCall new.
	us dateParm: '2021-08-30'.
	us timeParm: '16:11:00'.
	us latitudeParm: 36.8508 longitudeParm: -75.2859.
	us buildTheUrl; callTheApi.
	us inspect.
"
Class {
	#name : 'USACelestialNavigationDataForAssumedPositionAndTimeApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USACelestialNavigationDataForAssumedPositionAndTimeApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'celnav'.

]

{ #category : 'Not categorized' }
USACelestialNavigationDataForAssumedPositionAndTimeApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	dateAndTimeUtc := self class dateAndTimeFromDictionary: self properties.
	self getCelestialNavigationData.

]

{ #category : 'Not categorized' }
USACelestialNavigationDataForAssumedPositionAndTimeApiCall >> celestialNavigationData [
	"Answer the Celestial Navigation Data."

	^values ifNil: [#()].

]

{ #category : 'Not categorized' }
USACelestialNavigationDataForAssumedPositionAndTimeApiCall >> getCelestialNavigationData [
	"Get the Celestial Navigation Data."
	| theData |

	theData := self properties at: 'data' ifAbsent: [Array new].
	values := theData collect: [:s | USACelestialNavigationData data: s].

]

{ #category : 'Not categorized' }
USACelestialNavigationDataForAssumedPositionAndTimeApiCall >> moonIllumination [
	"Answer the moon illumination."

	^self properties at: 'moon_illum' ifAbsent: [].

]

{ #category : 'Not categorized' }
USACelestialNavigationDataForAssumedPositionAndTimeApiCall >> moonPhase [
	"Answer the moon phase."

	^self properties at: 'moon_phase' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USACelestialNavigationDataForAssumedPositionAndTimeApiCall >> printOn: aStream [
	"Print our data on the stream."
	| theNavigationData |

	super printOn: aStream.
	aStream nextPutAll: 'Moon Illumination: '; nextPutAll: self moonIllumination printString; cr.
	aStream nextPutAll: 'Moon Phase: '; nextPutAll: self moonPhase; cr.
	theNavigationData := self celestialNavigationData.
	theNavigationData notEmpty ifTrue: [
		aStream nextPutAll: 'ClestialNavigationData:'; cr.
		theNavigationData do: [:cnd |
			aStream tab.
			cnd printOn: aStream.
			aStream cr.
		].
	].

]
