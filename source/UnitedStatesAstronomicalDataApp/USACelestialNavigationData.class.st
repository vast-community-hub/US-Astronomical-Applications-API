"
USACelestialNavigationData
-
-	almanacData - USAAlmanacData from a USACelestialNavigationDataForAssumedPositionAndTimeApiCall.
-	altitudeCorrections - USAAltitudeCorrectionsData from a USACelestialNavigationDataForAssumedPositionAndTimeApiCall.

"
Class {
	#name : 'USACelestialNavigationData',
	#superclass : 'USAReplyData',
	#instVars : [
		'almanacData',
		'altitudeCorrections'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USACelestialNavigationData class >> data: aDictionary [
	"Create a new instance and set it's values."

	^self new data: aDictionary; yourself.

]

{ #category : 'Not categorized' }
USACelestialNavigationData >> almanacData [
	"Answer the almanacData of this Navigation Data."

	^almanacData.

]

{ #category : 'Not categorized' }
USACelestialNavigationData >> altitudeCorrections [
	"Answer the altitudeCorrections of this Navigation Data."

	^altitudeCorrections.

]

{ #category : 'Not categorized' }
USACelestialNavigationData >> data: aDictionary [
	"Set our values."

	almanacData := USAAlmanacData data: (aDictionary at: 'almanac_data' ifAbsent: [Dictionary new]).
	altitudeCorrections := USAAltitudeCorrectionsData data: (aDictionary at: 'altitude_corrections' ifAbsent: [Dictionary new]).
	value := aDictionary at: 'object' ifAbsent: [''].

]

{ #category : 'Not categorized' }
USACelestialNavigationData >> object [
	"Answer the object of this Navigation Data."

	^value.

]

{ #category : 'Not categorized' }
USACelestialNavigationData >> printOn: aStream [
	"Print our data on the stream."
	| indents |

	indents := self indentsNeeded: aStream.
	aStream nextPutAll: 'Object: '; nextPutAll: self object; cr.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Almanac Data: '; cr; tab.
	indents timesRepeat: [aStream tab].
	almanacData printOn: aStream.
	indents timesRepeat: [aStream tab].
	aStream nextPutAll: 'Altitude Corrections: '; cr; tab.
	indents timesRepeat: [aStream tab].
	altitudeCorrections printOn: aStream.

]
