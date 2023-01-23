"
USAJewishObservanceData

-	data from USAJewishObservancesApiCall
-
-	date - the date of the observance
-	value - the observance
-	observanceShortName - a short name for the observance
	jewishYear - the jewish year
-
	Answers booleans as to the kind of observance like isHanukkah

"
Class {
	#name : 'USAJewishObservanceData',
	#superclass : 'USAObservanceData',
	#instVars : [
		'jewishYear'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAJewishObservanceData >> data: aDictionary [
	"Set our values from the dictionary."
	| jYear |

	super data: aDictionary.
	jYear := aDictionary at: 'jewishyear' ifAbsent: [].
	jYear notNil ifTrue: [jewishYear := jYear asNumber].

	(value = 'First Day of Pesach (Passover)') ifTrue: [observanceShortName := 'Passover'].
	(value = 'Shavuot (Feast of Weeks)') ifTrue: [observanceShortName := 'Shavuot'].
	(value = 'Rosh Hashanah (Jewish New Year)') ifTrue: [observanceShortName := 'Rosh Hashanah'].
	(value = 'Yom Kippur (Day of Atonement)') ifTrue: [observanceShortName := 'Yom Kippur'].
	(value = 'First Day of Succoth (Feast of Tabernacles)') ifTrue: [observanceShortName := 'Succoth'].
	(value = 'First Day of Hanukkah (Festival of Lights)') ifTrue: [observanceShortName := 'Hanukkah'].

]

{ #category : 'Not categorized' }
USAJewishObservanceData >> isHanukkah [
	"Answer true if this data is for Hanukkah."

	^observanceShortName = 'Hanukkah'.

]

{ #category : 'Not categorized' }
USAJewishObservanceData >> isPassover [
	"Answer true if this data is for Passover."

	^observanceShortName = 'Passover'.

]

{ #category : 'Not categorized' }
USAJewishObservanceData >> isRoshHashanah [
	"Answer true if this data is for Rosh Hashanah."

	^observanceShortName = 'Rosh Hashanah'.

]

{ #category : 'Not categorized' }
USAJewishObservanceData >> isShavuot [
	"Answer true if this data is for Shavuot."

	^observanceShortName = 'Shavuot'.

]

{ #category : 'Not categorized' }
USAJewishObservanceData >> isSuccoth [
	"Answer true if this data is for Succoth."

	^observanceShortName = 'Succoth'.

]

{ #category : 'Not categorized' }
USAJewishObservanceData >> isYomKippur [
	"Answer true if this data is for Yom Kippur."

	^observanceShortName = 'Yom Kippur'.

]

{ #category : 'Not categorized' }
USAJewishObservanceData >> printOn: aStream [
	"Print our data on the stream."

	super printOn: aStream.
	aStream tab; nextPutAll: 'Jewish Year: '.
	jewishYear printOn: aStream.

]
