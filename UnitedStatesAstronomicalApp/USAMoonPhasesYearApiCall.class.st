"
-	""Phases of the Moon"" see: https://aa.usno.navy.mil/data/api#phase
-
-	This data service generates a list of primary moon phases with their dates and times.
-	The user may specify either the starting date for the list and the number of phases to calculate,
-	or a calendar year for all phases during that year.
-	The data can be produced for any year between 1700 and 2100 inclusive.
-	More information about this data service may be found at: https://aa.usno.navy.mil/data/MoonPhases
-
USAMoonPhasesYearApiCall gets the phase information for every moon phase of a given year.
-
-	see: USAMoonPhaseData

example:

	| us |
	us := USAMoonPhasesYearApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us phases inspect.
	us inspect.

"
Class {
	#name : 'USAMoonPhasesYearApiCall',
	#superclass : 'USAMoonPhasesApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAMoonPhasesYearApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'moon/phases/year'.

]
