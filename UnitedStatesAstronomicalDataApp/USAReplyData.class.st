"
USAReplyData is the super class for all the data returned from the services.

	It has instances variables of:

	dateAndTimeUtc - an instance of DateAndTime or USADateAndTime if the returned data has both a date and time.
	value - if the returned data has only one value.
	date - a Date if there is a date in the returned data.
	time - a Time or USAUT1Time if there is a time in the returned data.

"
Class {
	#name : 'USAReplyData',
	#superclass : 'Object',
	#instVars : [
		'dateAndTimeUtc',
		'value',
		'date',
		'time'
	],
	#pools : [
		'CldtConstants'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'Not categorized' }
USAReplyData class >> data: aDictionary [
	"Create a new instance and set its values from the dictionary."

	^self new data: aDictionary; yourself.

]

{ #category : 'Not categorized' }
USAReplyData >> data: aDictionary [
	"Set our values from the dictionary."

	self subclassResponsibility.

]

{ #category : 'Not categorized' }
USAReplyData >> date [
	"Answer the date of this data."

	^date notNil ifTrue: [date] ifFalse: [self dateAndTime ifNotNil: [:dt | dt date]].

]

{ #category : 'Not categorized' }
USAReplyData >> dateAndTime [
	"Answer the local dateAndTime of this data."

	^dateAndTimeUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
USAReplyData >> dateAndTimeFromDictionary: aDictionary [
	"Answer the dateAndTime from the values in the dictionary."

	^UnitedStatesAstronomicalApiCall dateAndTimeFromDictionary: aDictionary.

]

{ #category : 'Not categorized' }
USAReplyData >> dateAndTimeUtc [
	"Answer the dateAndTime of this data."

	^dateAndTimeUtc.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
USAReplyData >> dateFromDictionary: aDictionary [
	"Answer the date from the values in the dictionary."

	^UnitedStatesAstronomicalApiCall dateFromDictionary: aDictionary.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
USAReplyData >> indentsNeeded: aStream [
	"Answer the number of indents needed for #printOn: when called in one or more #printOn: calls."
	| lastNonTab | 

	lastNonTab := aStream contents reverse findFirst: [:c | c ~= Tab].
	^lastNonTab - 1.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
USAReplyData >> numberFromString: aString [
	"Answer the number value in the string."

	^UnitedStatesAstronomicalApiCall numberFromString: aString.

]

{ #category : 'Not categorized' }
USAReplyData >> time [
	"Answer the value of time."

	^time.

]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
USAReplyData >> timeFromDictionary: aDictionary [
	"Answer the time from the values in the dictionary."

	^UnitedStatesAstronomicalApiCall timeFromDictionary: aDictionary.

]

{ #category : 'Not categorized' }
USAReplyData >> value [
	"Answer the value of value."

	^value.

]
