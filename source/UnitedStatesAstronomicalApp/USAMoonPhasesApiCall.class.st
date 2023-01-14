"
""Phases of the Moon"" see: https://aa.usno.navy.mil/data/api#phase

	This data service generates a list of primary moon phases with their dates and times.
	The user may specify either the starting date for the list and the number of phases to calculate,
	or a calendar year for all phases during that year.
	The data can be produced for any year between 1700 and 2100 inclusive.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/MoonPhases

	This service supplies information about the phases of the moon.  The date/time and a brief
	description of the phase is supplied.
-
-	see: USAMoonPhaseData

USAMoonPhasesApiCall is a super class of USAMoonPhasesYearApiCall and USAMoonPhasesDateApiCall,
as such doesn't get instantiated.

"
Class {
	#name : 'USAMoonPhasesApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAMoonPhasesApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	self getPhaseData.

]

{ #category : 'Not categorized' }
USAMoonPhasesApiCall >> getPhaseData [
	"Get the moon phases."
	| phases |

	phases := self resultTable at: 'phasedata' ifAbsent: [Array new].
	values := phases collect: [:p | USAMoonPhaseData data: p].

]

{ #category : 'Not categorized' }
USAMoonPhasesApiCall >> phases [
	"Answer the moon phases."

	^values ifNil: [#()].

]

{ #category : 'Not categorized' }
USAMoonPhasesApiCall >> printOn: aStream [
	"Print our data on the stream."
	| thePhases |

	super printOn: aStream.
	thePhases := self phases.
	thePhases notEmpty ifTrue: [
		aStream nextPutAll: 'Phases:'; cr; tab.
		thePhases do: [:p |
			p printOn: aStream.
			aStream cr; tab.
		].
	].

]
