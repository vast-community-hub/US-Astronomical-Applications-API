"
USAIslamicObservanceData

-	data from USAIslamicObservancesApiCall
-
-	date - the date of the observance
-	value - the observance
-	observanceShortName - a short name for the observance
	islamicYear - the islamic year
-
	Answers booleans as to the kind of observance like isRamadan

"
Class {
	#name : 'USAIslamicObservanceData',
	#superclass : 'USAObservanceData',
	#instVars : [
		'islamicYear'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAIslamicObservanceData >> data: aDictionary [
	"Set our values from the dictionary."
	| iYear |

	super data: aDictionary.
	iYear := aDictionary at: 'islamicyear' ifAbsent: [].
	iYear notNil ifTrue: [islamicYear := iYear asNumber].

	(value = 'First Day of Ramadan') ifTrue: [observanceShortName := 'Ramadan'].
	(value = 'First Day of Shawwal') ifTrue: [observanceShortName := 'Shawwal'].
	(value = 'Islamic New Year') ifTrue: [observanceShortName := 'Islamic New Year'].

]

{ #category : 'Not categorized' }
USAIslamicObservanceData >> isIslamicNewYear [
	"Answer true if this data is for Islamic New Year."

	^observanceShortName = 'Islamic New Year'.

]

{ #category : 'Not categorized' }
USAIslamicObservanceData >> isRamadan [
	"Answer true if this data is for Ramadan."

	^observanceShortName = 'Ramadan'.

]

{ #category : 'Not categorized' }
USAIslamicObservanceData >> isShawwal [
	"Answer true if this data is for Shawwal."

	^observanceShortName = 'Shawwal'.

]

{ #category : 'Not categorized' }
USAIslamicObservanceData >> printOn: aStream [
	"Print our data on the stream."

	super printOn: aStream.
	aStream tab; nextPutAll: 'Islamic Year: '.
	islamicYear printOn: aStream.

]
