"
USAObservancesApiCall is a super class of USAChristianObservancesApiCall, USAJewishObservancesApiCall
and USAIslamicObservancesApiCall, as such doesn't get instantiated.
-
- See each class comment for more information.

"
Class {
	#name : 'USAObservancesApiCall',
	#superclass : 'UnitedStatesAstronomicalApiCall',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
USAObservancesApiCall class >> observanceDataClass [
	"The class of out observance data."

	^self subclassResponsibility.

]

{ #category : 'Not categorized' }
USAObservancesApiCall >> callTheApi [
	"Call the api with our url."

	super callTheApi.
	self getObservancesData.

]

{ #category : 'Not categorized' }
USAObservancesApiCall >> getObservancesData [
	"Get the observances."
	| observances |

	observances := self resultTable at: 'data' ifAbsent: [Array new].
	values := observances collect: [:o | self class observanceDataClass data: o].

]

{ #category : 'Not categorized' }
USAObservancesApiCall >> observances [
	"Answer the observances."

	^values ifNil: [#()].

]

{ #category : 'Not categorized' }
USAObservancesApiCall >> printOn: aStream [
	"Print our data on the stream."
	| thePhases |

	super printOn: aStream.
	thePhases := self observances.
	thePhases notEmpty ifTrue: [
		aStream nextPutAll: 'Observances:'; cr.
		thePhases do: [:o |
			aStream tab.
			o printOn: aStream.
			aStream cr.
		].
	].

]
