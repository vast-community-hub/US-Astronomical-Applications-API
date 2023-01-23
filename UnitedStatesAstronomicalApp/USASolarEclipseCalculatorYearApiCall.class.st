"
-	""Solar Eclipse Calculator"" see: https://aa.usno.navy.mil/data/api#soleclipse
-
-	This data service provides local circumstances for solar eclipses,
-	and also provides a means for determining dates and types of eclipses in a given year.
-
-	For the local circumstances, data will be provided from 2017 through 2024.
-	For dates outside of this range, see MICA at: https://aa.usno.navy.mil/software/mica_info
-
-	This service requires a location and date, and may include height.
-	More information about this data service may be found at: https://aa.usno.navy.mil/data/SolarEclipses
-
-	For a list of eclipses in a selected year, data will be provided for 1800 through 2050.
-
-
USASolarEclipseCalculatorYearApiCall example:

	| us |
	us := USASolarEclipseCalculatorYearApiCall new.
	us yearParm: 2017.
	us buildTheUrl; callTheApi.
	us eclipses inspect.
	us inspect.
"
Class {
	#name : 'USASolarEclipseCalculatorYearApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USASolarEclipseCalculatorYearApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'eclipses/solar/year'.

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorYearApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	self getEclipsesData.

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorYearApiCall >> eclipses [
	"Answer the Eclipses for the year."

	^values ifNil: [#()].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorYearApiCall >> getEclipsesData [
	"Get the Eclipses for the year."
	| seasons |

	seasons := self resultTable at: 'eclipses_in_year' ifAbsent: [Array new].
	values := seasons collect: [:e | USAEclipseInYearData data: e].

]

{ #category : 'Not categorized' }
USASolarEclipseCalculatorYearApiCall >> printOn: aStream [
	"Print our data on the stream."
	| theEclipses |

	super printOn: aStream.
	theEclipses := self eclipses.
	theEclipses notEmpty ifTrue: [
		aStream nextPutAll: 'Eclipses:'; cr.
		theEclipses do: [:e |
			aStream tab.
			e printOn: aStream.
			aStream cr.
		].
	].

]
