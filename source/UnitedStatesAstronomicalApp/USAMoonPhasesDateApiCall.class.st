"
-	""Phases of the Moon"" see: https://aa.usno.navy.mil/data/api#phase
-
-	This data service generates a list of primary moon phases with their dates and times.
-	The user may specify either the starting date for the list and the number of phases to calculate,
-	or a calendar year for all phases during that year.
-	The data can be produced for any year between 1700 and 2100 inclusive.
-	More information about this data service may be found at: https://aa.usno.navy.mil/data/MoonPhases
-
USAMoonPhasesDateApiCall gets the phase information starting at given date, for a given number of phases.
-
-	see: USAMoonPhaseData

	In this example a starting date and the number of phases desired are supplied.  The first day of the month
	and five (5) phases are asked for because that should get all the phases for the month (and maybe one more).

	| us |
	us := USAMoonPhasesDateApiCall new.
	us dateParm: Date today firstDayOfMonth.
	us numberOfPhasesParm: 5.
	us buildTheUrl; callTheApi.
	us phases inspect.
	us inspect.

"
Class {
	#name : 'USAMoonPhasesDateApiCall',
	#superclass : 'USAMoonPhasesApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAMoonPhasesDateApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'moon/phases/date'.

]
