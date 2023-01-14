Class {
	#name : 'USADateAndTime',
	#superclass : 'Magnitude',
	#instVars : [
		'microseconds',
		'timeZone'
	],
	#classVars : [
		'HighOffset',
		'LocalTimeZone',
		'ClockPrecision',
		'LowOffset'
	],
	#pools : [
		'CldtConstants'
	],
	#category : 'UnitedStatesAstronomicalDataApp'
}

{ #category : 'ANSI-API' }
USADateAndTime class >> clockPrecision [
	"Synopsis
		Answer a <Duration> such that after that period of time passes, #now is guaranteed to give a
		different result.

	 Definition: <DateAndTime factory>
		Answer a <Duration> such that after that period of time passes, #now is guaranteed to give a
		different result. Ideally implementations should answer the least such duration.

	 Return Values:
		<Duration> unspecified

	 Errors
		None"

	^ ClockPrecision
]

{ #category : 'Not categorized' }
USADateAndTime class >> fromUtcMicroseconds: microseconds [
	"Create a new instance and set the microseconds and #UTC timezone."

	^self new fromUtcMicroseconds: microseconds; yourself.

]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime class >> initializeAfterLoad [

	ClockPrecision := Duration milliseconds: 1.

	LowOffset := Duration seconds: -43200. "TZ Pacific/Enderbury has offset of -43200"
	HighOffset := Duration seconds: 50400 "TZ posix/Pacific/Kiritimati has offset 50400"
]

{ #category : 'ES-API' }
USADateAndTime class >> localTimeZone [
	"Answer the local time zone"

	LocalTimeZone ifNil: [LocalTimeZone := EsTimeZoneDatabase defaultTimeZone].
	^LocalTimeZone
]

{ #category : 'ES-API' }
USADateAndTime class >> localTimeZone: aTimeZone [

	LocalTimeZone := aTimeZone

]

{ #category : 'ES-API' }
USADateAndTime class >> nowUTC [
	"Synopsis
	Answer a <DateAndTime> representing the current date and time.

	Definition: <DateAndTime factory>
	Answer a <DateAndTime> representing the current date and time in the UTC timezone.

	Return Values
	<DateAndTime> unspecified

	Errors
	None"

	| currentDateAndTime |

	currentDateAndTime := Date dateAndTimeNowUTC.
	^self fromUtcMicroseconds: ((currentDateAndTime at: 1) asMilliseconds * MicrosecondsPerMillisecond) +
		((currentDateAndTime at: 2) asMilliseconds * MicrosecondsPerMillisecond).

]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime class >> primitiveSystemOffset [
	"Answer an <Integer> representing the westward displacement of system local time
	 from UTC in seconds.  The value can be betwen 0 and 86400 minutes."

	<primitive: TzOffset>
	^self primitiveFailed


]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime class >> systemOffset [
	"Answer a <Duration> representing the difference between UTC and system
	 local time.  The value can be between -12 and +12 hours.  For example,
	 Eastern Standard Time (EST) has a value of -5 hours (5 hours earlier than UTC)."

	| temp |

	temp := self primitiveSystemOffset.
	^ temp < (SecondsPerDay / 2)
		ifTrue: [ Duration seconds: temp negated ]
		ifFalse: [ Duration seconds: SecondsPerDay - temp ]
]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime class >> timeZoneOffset [

	"Answer a <Duration> representing the difference between UTC and system
	 local time.  The value can be between -12 and +12 hours.  For example,
	 Eastern Standard Time (EST) has a value of -5 hours (5 hours earlier than UTC)."

	^self localTimeZone offset.
]

{ #category : 'ANSI-API' }
USADateAndTime >> + aDuration [
	"Answer a <DateAndTime> that represents the UTC time that is
	 @aDuration after the receiver and whose local time is the same
	 as the receiver's.  If @aDuration is less than <Duration Factory>
	 #zero, the result is a <DateAndTime> that is the absolute value
	 of @aDuration before the receiver."

	| dt |

	dt := self deepCopy. "do a deepCopy to preserve the timeZone"
	dt totalMicroseconds: dt asMicroseconds + aDuration microseconds.
	dt timeZone
		timeZoneRule: (dt timeZone zoneRuleFor: dt asMilliseconds / 1000.0  - EsTimeZoneDatabase posixOffset).
	^dt.

]

{ #category : 'ANSI-API' }
USADateAndTime >> - operand [
	"Answer the result of substracting @operand from the receiver.

	 If @operand is a <DateAndTime>, answer a <Duration> whose value is
	 the period of time between @operand and the receiver.  If @operand
	 is a <DateAndTime> prior to the receiver, then the result is a
	 <Duration> less than <Duration factory> #zero.

	 If @operand is a <Duration>, answer a <DateAndTime> which represents
	 the UTC time that is @operand before the receiver and whose local
	 time is the same as the receiver's.  If @operand is a <Duration> less
	 than <Duration factory> #zero, then the result is a <DataAndTime>
	 that is the absolute value of @operand after the receiver."

	^operand subtractFromDateAndTime: self
]

{ #category : 'ANSI-API' }
USADateAndTime >> < operand [
	"Synopsis
		Answer true if the receiver is less than @operand. Answer false otherwise.

	 Definition: <magnitude>
		Answer true if the receiver is less than @operand with respect to the ordering defined for them.
		Answer false otherwise.

		It is erroneous if the receiver and @operand are not comparable.

		The semantics of the natural ordering must be defined by refinement, which may also restrict the
		type of @operand.

	 Refinement: <DateAndTime>
		Answer true if the UTC time represented by @operand follows the UTC time represented by the
		receiver. Answer false otherwise.

		If the offsets of the receiver and @operand are the same then their order is determined by their
		lexical order in the sequence #year, #month, #day, #hour24, #minute, #second. If their
		offsets differ then result is the same as if receiver asUTC < operand asUTC were evaluated.

	 Parameters
		@operand <DateAndTime> uncaptured

	 Return Values
		<boolean> unspecified

	 Errors
		None"

	^ self asMicroseconds < operand asMicroseconds
]

{ #category : 'ANSI-API' }
USADateAndTime >> = aDateAndTime [
	"Synopsis
		Object equivalence test.

	 Definition: <Object>
		This message tests whether the receiver and the comparand are equivalent objects at the time the
		message is processed. Return true if the receiver is equivalent to comparand. Otherwise return
		false.

		The meaning of 'equivalent' cannot be precisely defined but the intent is that two objects are
		considered equivalent if they can be used interchangeably. Conforming protocols may choose to
		more precisely define the meaning of 'equivalent'.

		The value of
			receiver = comparand
		is true if and only if the value of
			comparand = receiver
		would also be true. If the value of
			receiver = comparand
		is true then the receiver and comparand must have equivalent hash values.
		
		The equivalence of objects need not be temporally invariant. Two independent invocations of #=
		with the same receiver and operand objects may not always yield the same results. Note that a
		collection that uses #= to discriminate objects may only reliably store objects whose hash values
		do not change while the objects are contained in the collection.

	 Refinement: <DateAndTime>
		Answer true if the comparand conforms to <DateAndTime> and if it represents the
		same UTC time as the receiver. Answer false otherwise. The local times of the receiver and
		operand are ignored.

	 Parameters
		comparand <Object> uncaptured

	 Return Values
		<boolean> unspecified

	 Errors
		none"
		
	^ self == aDateAndTime or: [
		self species = aDateAndTime species
			and: [self asMicroseconds = aDateAndTime asMicroseconds ] ]
]

{ #category : 'Not categorized' }
USADateAndTime >> asDateAndTime [
	"Answer a real DateAndTime based upon milliseconds and not microseconds."

	^DateAndTime fromUtcMilliseconds: self asMilliseconds.

]

{ #category : 'ANSI-API' }
USADateAndTime >> asLocal [
	"Answer a <DateAndTime> that represent the same UTC as the receiver,
	 but in the local time specified by the implementation."

	timeZone timeZoneName = self localTimeZone timeZoneName ifTrue: [^self deepCopy].

	^self transformToTimeZone: self localTimeZone
]

{ #category : 'Not categorized' }
USADateAndTime >> asMicroseconds [
	"Answer the value of the receiver in milliseconds.  A zero value
	 corresponds to 00:00 UTC on January 1, 1901."

	^microseconds.

]

{ #category : 'ES-API' }
USADateAndTime >> asMilliseconds [
	"Answer the value of the receiver in milliseconds.  A zero value
	 corresponds to 00:00 UTC on January 1, 1901."

	^(microseconds / 1000) asInteger.

]

{ #category : 'ES-Internal' }
USADateAndTime >> asPointInTime [

	^(self asMilliseconds / 1000.0) - EsTimeZoneDatabase posixOffset
]

{ #category : 'ES-Internal' }
USADateAndTime >> asSeconds [

	^(microseconds / MicrosecondsPerSecond) asInteger
]

{ #category : 'ANSI-API' }
USADateAndTime >> asUTC [
	"Answer a <DateAndTime> that represents the same absolute time as
	 the receiver but in UTC."

	| newDT |

	newDT := self deepCopy.

	newDT timeZone timeZoneName: #UTC.
	newDT timeZone
		timeZoneRule: (EsTimeZoneDatabase createDummyTimeZoneRuleForSeconds: 0 timeZoneName: #UTC).
	^newDT
]

{ #category : 'Not categorized' }
USADateAndTime >> canBeLowResolutionTime [
	"Answer true if if our time part can be accurately represented as a Time."

	^(microseconds - (self asMilliseconds * MicrosecondsPerMillisecond)) = 0.

]

{ #category : 'ES-Internal' }
USADateAndTime >> computeTimeZoneOffset: anIntegerNumberOfSeconds [

	| posixSeconds secondsSinceTransition offsetDifference timeZoneOffset |

	timeZoneOffset :=
		timeZone timeZoneRuleSet
			localOffsetSecondsAt: anIntegerNumberOfSeconds - EsTimeZoneDatabase posixOffset.

	timeZoneOffset >= 0
		ifTrue: [
			timeZoneOffset :=
				timeZone timeZoneRuleSet
					minOffsetFor: anIntegerNumberOfSeconds - EsTimeZoneDatabase posixOffset].

	posixSeconds := anIntegerNumberOfSeconds - EsTimeZoneDatabase posixOffset - timeZoneOffset.

	timeZone timeZoneRule: (timeZone zoneRuleFor: posixSeconds).

	timeZone isDst ifFalse: [^timeZone offsetSeconds].

	"It is illegal to create a DateAndTime in the Interval from: 0 to: 3599999 milliseconds after a transition -to- DST, assuming that the offset difference is 3600 seconds. There are no such times.
	For instance. America/New York went to DST one millisecond after 2014-03-09T01:59:59:999-05:00 when the time instantly became 2014-03-09T03:00:00.000-04:00. 
	There are no legal times in the interval 2014-03-09T02:00:00.000 to 2014-03-09T02:59:59.999"

	offsetDifference := "usually 3600"
		(timeZone timeZoneRule offsetSeconds - timeZone timeZoneRule prevOffsetSeconds) abs.

	secondsSinceTransition := (posixSeconds - timeZone timeZoneRule transitionTime) abs.

	secondsSinceTransition > offsetDifference ifTrue: [^timeZone offsetSeconds].
	(secondsSinceTransition < offsetDifference
		or: [secondsSinceTransition = 0 and: [offsetDifference = 0]])
			ifTrue: [
				self error: (
					'attempt to create an illegal date and time in time zone ' ,
						self timeZone printString)].

	^timeZone offsetSeconds



]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime >> copyWithOffset: aDuration [

	^self deepCopy setOffset: aDuration
]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime >> date [
	"Answer a <Date> representing the local date in the Gregorian calendar
	 of the receiver."

	^Date fromDays: self asMilliseconds + self offset asMilliseconds  // (MillisecondsPerSecond * SecondsPerDay).

]

{ #category : 'ANSI-API' }
USADateAndTime >> dayOfMonth [
	"Answer the number of the day in the month in the local time of the
	 receiver which includes the receiver."

	^self date dayOfMonth
]

{ #category : 'ANSI-API' }
USADateAndTime >> dayOfWeek [
	"Answer the number of the day in the week, in the local time of the
	 receiver, which includes the receiver.  Sunday is 1, Monday is 2,
	 and so on."

	^self date dayIndex
]

{ #category : 'ANSI-API' }
USADateAndTime >> dayOfWeekAbbreviation [
	"Answer the abbreviation of the name, in the local time of the reciever,
	 of the day of the week which includes the receiver."

	^Locale current lcTime abDay at: self dayOfWeek
]

{ #category : 'ANSI-API' }
USADateAndTime >> dayOfWeekName [
	"Answer the name, in the local time of the receiver, of the day of the
	 week which includes the receiver."

	^Locale current lcTime day at: self dayOfWeek
]

{ #category : 'ANSI-API' }
USADateAndTime >> dayOfYear [
	"Answer the number of the day in the year, in the local time of the
	 receiver, which includes the receiver."

	^self date dayOfYear
]

{ #category : 'Not categorized' }
USADateAndTime >> fromUtcMicroseconds: integerMicroseconds [

	timeZone := EsTimeZoneDatabase timeZoneFor: #UTC.
	microseconds := integerMicroseconds.

]

{ #category : 'ANSI-API' }
USADateAndTime >> hash [

	^ self asMicroseconds hash
]

{ #category : 'ANSI-API' }
USADateAndTime >> hour [
	"Answer the number of the hour in the day, in the local time of the
	 receiver, which includes the receiver."

	^self hour24
]

{ #category : 'ANSI-API' }
USADateAndTime >> hour12 [
	"Answer the number of the hour in the day, in the local time of the
	 receiver, which includes the receiver using a 12-hour clock
	 representation.  The result is in the range 1 to 12."

	| mod |

	^(mod := self hour \\ 12) == 0
		ifTrue: [12]
		ifFalse: [mod]
]

{ #category : 'ANSI-API' }
USADateAndTime >> hour24 [
	"Answer the number of the hour in the day, in the local time of the
	 receiver, which includes the receiver using the 24-hour clock
	 representation.  The result is in the range 0 to 23."

	^self time hours
]

{ #category : 'ES-API' }
USADateAndTime >> isDst [

	^timeZone isDst
]

{ #category : 'ANSI-API' }
USADateAndTime >> isLeapYear [
	"Answer true if the year which includes the receiver , in the local time
	 of the receiver, is a leap year."

	^(Date leapYear: self year) == 1
]

{ #category : 'ES-Internal' }
USADateAndTime >> julianDayNumber [

	| a y m julianDayNumber |

	a := (14 - self month) quo: 12.
	y := self year + 4800 - a.
	m := self month + (12 * a) - 3.

	julianDayNumber :=
		self dayOfMonth + ((153 * m + 2) quo: 5) + (365 * y) + (y quo: 4) - (y quo: 100) +
			(y quo: 400) - 32045.

	^julianDayNumber
]

{ #category : 'ES-API' }
USADateAndTime >> localTimeZone [

	^self class localTimeZone
]

{ #category : 'ANSI-API' }
USADateAndTime >> meridianAbbreviation [
	"Answer the abbreviation of the name of the half day, in the local time
	 of the receiver, which includes the receiver."

	^self hour24 < 12
		ifTrue: [Locale current lcTime amPm first]
		ifFalse: [Locale current lcTime amPm last]
]

{ #category : 'ANSI-API' }
USADateAndTime >> minute [
	"Answer the number of the minute in the hour, in the local time of the
	 receiver, which includes the receiver."

	^self time minutes
]

{ #category : 'ANSI-API' }
USADateAndTime >> month [
	"Answer the number of the month in the year, in the local time of the
	 receiver, which includes the receiver."
 
	^self date monthIndex
]

{ #category : 'ANSI-API' }
USADateAndTime >> monthAbbreviation [
	"Answer the abbreviation of the name of the month, in the local time of
	 the receiver, which includes the receiver."

	^Locale current lcTime abMon at: self month
]

{ #category : 'ANSI-API' }
USADateAndTime >> monthName [
	"Answer the name of the month, in the local time of the receiver,
	 which includes the receiver."

	^Locale current lcTime mon at: self month
]

{ #category : 'ANSI-API' }
USADateAndTime >> offset [
	"Answer a <Duration> representing the difference between the local
	 time of the receiver and UTC."

	^timeZone offset
]

{ #category : 'ANSI-API' }
USADateAndTime >> offset: aDuration [
	"Synopsis
		Answer a <DateAndTime> equivalent to the receiver but with its local time being offset from UTC
		by @anOffset.

	 Definition: <DateAndTime>
		Answer a <DateAndTime> equivalent to the receiver but with its local time being offset from UTC
		by @anOffset. The impact of this on any other local time property is unspecified.
		Implementations may define a limit to the range of @anOffset, but it must be at least
		-12:00:00 to 12:00:00 inclusive.

		It is an invariant that if x is a <Duration> in range then
			(<DateAndTime> offset: x) offset = x

	 Parameters
		@anOffset <Duration> unspecified

	 Return Values
		<DateAndTime> unspecified

	 Errors
		@anOffset out of range."

	(aDuration between: LowOffset and: HighOffset) ifFalse: [ExCLDTValueOutOfRange signalWith: 1].

	self setTimeZoneFromOffset: aDuration totalSeconds
]

{ #category : 'Not categorized' }
USADateAndTime >> printMicrosecondsOn: aStream [
	"Print the last 6 digits of our microseconds, without trailing zeros on @aStream."
	| temp digits f |

	temp := microseconds rem: 1000000.
	(temp ~= 0) ifTrue: [
		aStream nextPut: $..	"$NON-NLS$"
		digits := temp printPaddedWith: $0 to: 6.
		f := digits reverse findFirst: [:d | d ~= $0].
		aStream nextPutAll: (digits copyFrom: 1 to: (7 - f)).
	].

]

{ #category : 'ANSI-API' }
USADateAndTime >> printOn: aStream [
	"Append to the argument @aStream, a sequence of characters that
	 describes the receiver.

	 Fail if @aStream is not a kind of Stream."

	"The DateAndTime message refinement for printString in the ANSI Standard section 5.8.1.24
	 states that the first character of the representation ""is the <Character> $- if the year is less
	 than 0; otherwise it is the <Character> that is returned from the message #space sent to the
	 standard global Character.""  However, since the representation is supposed to be drawn from
	 ISO 8601, we should refer to that standard for information also.  ISO 8601, in section 4.4
	 Characters used in the representation, states ""The space character shall not be used in the
	 representations.""  Further, as would be expected, none of the examples in ISO 8601 show a
	 leading space. 

	 I conclude that section 5.8.1.24 is incorrect and that the statement should be that the first
	 character of the representation ""is the <Character> $- if the year is less than 0; otherwise
	 it is omitted.""  Therefore, the implementation of DateAndTime>>#printOn: omits the leading
	 space." 

	Locale current lcTime copy
		dFmt: '%Y-%m-%d';	"$NON-NLS$"
		tFmt: 'T%H:%M:%S';	"$NON-NLS$"
		printDate: self date on: aStream;
		printTime: self time on: aStream.
	self printMicrosecondsOn: aStream.

	"Print the offset -- don't use Duration>>#printOn: because the format is not right"
	self offset negative
		ifTrue: [aStream nextPut: $-]	"$NON-NLS$"
		ifFalse: [aStream nextPut: $+].	"$NON-NLS$"
	aStream 
		nextPutAll: (self offset hours abs printStringRadix: 10 padTo: 2);
		nextPut: $:;	"$NON-NLS$"
		nextPutAll: (self offset minutes abs printStringRadix: 10 padTo: 2).
	self offset seconds = 0 ifFalse: [
		aStream
			nextPut: $:;	"$NON-NLS$"
			nextPutAll: (self offset seconds abs printStringRadix: 10 padTo: 2)].

]

{ #category : 'ANSI-API' }
USADateAndTime >> second [
	"Answer the number of the second in the minute, in the local time of the
	 receiver, which includes the receiver."

	^self time seconds
]

{ #category : 'ES-Deprecated',
  #vaVisibility : 'private' }
USADateAndTime >> setOffset: aDuration [
	"Deprecated -- use offset: instead."
	
	self offset: aDuration
]

{ #category : 'ES-Internal' }
USADateAndTime >> setTimeZoneFromOffset [

	self setTimeZoneFromOffset: self offset asSeconds
]

{ #category : 'ES-Internal' }
USADateAndTime >> setTimeZoneFromOffset: offsetSeconds [

	timeZone := EsTimeZoneDatabase createDummyTimeZoneForSeconds: offsetSeconds
]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime >> subtractFromDateAndTime: aDateAndTime [
	"Answer a <Duration> which is the result of substracting the receiver
	 from @aDateAndTime."
	| newTotalSeconds newTotalMicroseconds newMicroSeconds |

	newTotalMicroseconds := aDateAndTime asMicroseconds - self asMicroseconds.
	newTotalSeconds := newTotalMicroseconds // MicrosecondsPerSecond.
	newMicroSeconds := newTotalMicroseconds - (newTotalSeconds * MicrosecondsPerSecond).
	 ^Duration totalSeconds: newTotalSeconds microseconds: newMicroSeconds.

]

{ #category : 'ANSI-Internal',
  #vaVisibility : 'private' }
USADateAndTime >> time [
	"Answer a <Time> representing the local time within a date
	 of the receiver."

	^Time fromMilliseconds: self asMilliseconds + self offset asMilliseconds
]

{ #category : 'ES-API' }
USADateAndTime >> timeZone [
	^timeZone
]

{ #category : 'ES-API' }
USADateAndTime >> timeZone: anObject [
	timeZone := anObject
]

{ #category : 'ANSI-API' }
USADateAndTime >> timeZoneAbbreviation [
	"Answer the abbreviation of the name, in the local time of the receiver,
	 of the time zone of the receiver."

	^timeZone abbreviation
]

{ #category : 'ANSI-API' }
USADateAndTime >> timeZoneName [
	"Answer the name, in the local time of the receiver,  of the time zone
	 of the receiver."

	^self timeZone name
]

{ #category : 'Not categorized' }
USADateAndTime >> totalMicroseconds: anInteger [
	"Set the value of the receiver to @anInteger microseconds.  A zero value
	 corresponds to 00:00 UTC on January 1, 1901."

	microseconds := anInteger.

]

{ #category : 'ES-Internal' }
USADateAndTime >> transformToTimeZone: aTimeZoneRuleSet [

	| newDT |

	newDT := self deepCopy.

	newDT timeZone timeZoneName: aTimeZoneRuleSet timeZoneName.
	newDT timeZone timeZoneRule: (newDT timeZone zoneRuleFor: newDT asPointInTime abs).
	^newDT
]

{ #category : 'ES-API' }
USADateAndTime >> transformToTimeZoneNamed: timeZoneName [

	^self deepCopy transformToTimeZone: (EsTimeZoneDatabase timeZoneFor: timeZoneName)
]

{ #category : 'ANSI-API' }
USADateAndTime >> year [
	"Answer the number of the year, in the local time of the receiver, which
	 includes the receiver."

	^self date year
]
