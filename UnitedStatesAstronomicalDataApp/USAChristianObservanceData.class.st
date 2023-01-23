"
USAChristianObservanceData

-	data from USAChristianObservancesApiCall
-
-	date - the date of the observance
-	value - the observance
-	observanceShortName - a short name for the observance
-
	Answers booleans as to the kind of observance like isEaster

"
Class {
	#name : 'USAChristianObservanceData',
	#superclass : 'USAObservanceData',
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAChristianObservanceData >> data: aDictionary [
	"Set our values from the dictionary."

	super data: aDictionary.
	observanceShortName := value.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isAdvent [
	"Answer true if this data is for First Sunday in Advent."

	^value = 'First Sunday in Advent'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isAscensionDay [
	"Answer true if this data is for Ascension Day."

	^value = 'Ascension Day'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isAshWednesday [
	"Answer true if this data is for Ash Wednesday."

	^value = 'Ash Wednesday'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isEaster [
	"Answer true if this data is for Easter."

	^value = 'Easter'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isGoodFriday [
	"Answer true if this data is for Good Friday."

	^value = 'Good Friday'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isPalmSunday [
	"Answer true if this data is for Palm Sunday."

	^value = 'Palm Sunday'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isPentecost [
	"Answer true if this data is for Whit Sunday -- Pentecost."

	^value = 'Whit Sunday -- Pentecost'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isTrinitySunday [
	"Answer true if this data is for Trinity Sunday."

	^value = 'Trinity Sunday'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> isWhitSunday [
	"Answer true if this data is for Whit Sunday -- Pentecost."

	^value = 'Whit Sunday -- Pentecost'.

]

{ #category : 'Not categorized' }
USAChristianObservanceData >> printOn: aStream [
	"Print our data on the stream."

	super printOn: aStream.

]
