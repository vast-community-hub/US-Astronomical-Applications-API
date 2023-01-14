"
""Earth's Seasons - Equinoxes, Solstices, Perihelion, and Aphelion"" see: https://aa.usno.navy.mil/data/api#seasons

	This data service calculates the dates and times of Earth's seasons and apsides.
	Data will be provided for the years 1700 through 2100 inclusive.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/Earth_Seasons

USAEarthSeasonsApiCall example:

	| us |
	us := USAEarthSeasonsApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us seasons inspect.
	us inspect.

"
Class {
	#name : 'USAEarthSeasonsApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAEarthSeasonsApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^'seasons'.

]

{ #category : 'Not categorized' }
USAEarthSeasonsApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	self getSeasonsData.

]

{ #category : 'Not categorized' }
USAEarthSeasonsApiCall >> getSeasonsData [
	"Get the earth seasons."
	| seasons |

	seasons := self resultTable at: 'data' ifAbsent: [Array new].
	values := seasons collect: [:s | USASeasonData data: s].

]

{ #category : 'Not categorized' }
USAEarthSeasonsApiCall >> printOn: aStream [
	"Print our data on the stream."
	| theSeasons |

	super printOn: aStream.
	theSeasons := self seasons.
	theSeasons notEmpty ifTrue: [
		aStream nextPutAll: 'Seasons:'; cr.
		theSeasons do: [:s |
			aStream tab.
			s printOn: aStream.
			aStream cr.
		].
	].

]

{ #category : 'Not categorized' }
USAEarthSeasonsApiCall >> seasons [
	"Answer the earth seasons."

	^values ifNil: [#()].

]
