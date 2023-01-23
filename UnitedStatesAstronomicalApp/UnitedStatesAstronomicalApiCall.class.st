"
UnitedStatesAstronomicalApiCall is the super class of all USA...ApiCalls, as such doesn't get instantiated.

"
Class {
	#name : 'UnitedStatesAstronomicalApiCall',
	#superclass : 'Object',
	#instVars : [
		'resultTable',
		'url',
		'id',
		'parameters',
		'values',
		'dateAndTimeUtc'
	],
	#classVars : [
		'ApiUrl'
	],
	#pools : [
		'CldtConstants',
		'SstConstants',
		'NlsCatSSTG'
	],
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> apiUrl [
	"Answer the url of the United States Astronomical Api from our values."

	ApiUrl isNil ifTrue: [ApiUrl := 'https://aa.usno.navy.mil/api/'].
	^ApiUrl.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> apiUrl: aString [
	"Set the url of the United States Astronomical Api from our values."

	ApiUrl := aString.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^self subclassResponsibility.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> dateAndTimeFromDictionary: aDictionary [
	"Answer the dateAndTime from the values in the dictionary."
	| dateAndtimeMicroseconds dateAndtimeMilliseconds datePart timePart isHighResolutionTime |

	datePart := self dateFromDictionary: aDictionary.
	timePart := self timeFromDictionary: aDictionary.
	^datePart notNil ifTrue: [
		isHighResolutionTime := timePart notNil and: [timePart isHighResolutionTime].
		isHighResolutionTime ifTrue: [
			dateAndtimeMicroseconds := (datePart asMilliseconds * MicrosecondsPerMillisecond) + timePart asMicroseconds.
			USADateAndTime fromUtcMicroseconds: dateAndtimeMicroseconds.
		] ifFalse: [
			dateAndtimeMilliseconds := datePart asMilliseconds + (timePart notNil ifTrue: [timePart asMilliseconds] ifFalse: [0]).
			DateAndTime new fromMilliseconds: dateAndtimeMilliseconds timeZoneRuleSet: (EsTimeZoneDatabase timeZoneFor: #UTC); yourself.
		].
	] ifFalse: [].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> dateFromDictionary: aDictionary [
	"Answer the date from the values in the dictionary."
	| day month year dDay dMonth dYear |

	^aDictionary isEmpty ifTrue: [] ifFalse: [
		dDay := aDictionary at: 'day' ifAbsent: [0].
		day := dDay isNumber ifTrue: [dDay] ifFalse: [self numberFromString: dDay].
		dMonth := aDictionary at: 'month' ifAbsent: [0].
		month := dMonth isNumber ifTrue: [dMonth] ifFalse: [self numberFromString: dMonth].
		dYear := aDictionary at: 'year' ifAbsent: [0].
		year := dYear isNumber ifTrue: [dYear] ifFalse: [self numberFromString: dYear].

		Date newDay: day monthIndex: month year: year.
	].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> numberFromString: aString [
	"Answer the number from the value in the string.  Remove any bad characters."
	| aStream |

	aStream := WriteStream on: (String new: aString size).
	aString do: [:c | ('0123456789-+.' includes: c) ifTrue: [aStream nextPut: c]].
	^Number readFrom: aStream contents ifFail: [0].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> timeFromDictionary: aDictionary [
	"Answer the time from the values in the dictionary.  If the time is a whole number of milliseconds, as instance of Time is answered."

	^USAUT1Time fromUSAString: (aDictionary at: self timeKey ifAbsent: ['']).

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall class >> timeKey [
	"Answer the key used to get the time from the dictionary."

	^'time'.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> apiUrl [
	"Answer the url of the United States Astronomical Api from our values."

	^self class apiUrl.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> apiVersion [
	"Answer the version of the United States Astronomical Api."

	^resultTable notNil ifTrue: [resultTable at: 'apiversion' ifAbsent: ['']] ifFalse: [''].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> buildTheUrl [
	"Build the url used to call the United States Astronomical Api from our values."

	url := '%1%2?%3%4' bindWith: self apiUrl with: self dataService with: self idParm with: self parametersString.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> callisto [
	"Set the body parameter."

	self parameters at: 'body' put: 'callisto'.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> callTheApi [
	"Call the api with our url."
	| result resultStream reader |

	result := [
		[(SstUrl fromString: url) fetch] whenTimeoutInMilliseconds: 20000 do: [:toSig |
			toSig exitWith: (SstError for: ExSstNonFatalError with: MxSSTG122)]
	] on: Error do: [:sig | sig exitWith: nil].
	resultTable := (result notNil and: [result isSstError not]) ifTrue: [
		resultStream := ReadStream on: result.
		reader := STONReader on: resultStream.
		reader next.
	] ifFalse: [Dictionary new].
	^resultTable.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> dataService [
	"Answer the string that defines the data service to call in the United States Astronomical Api."

	^self class dataService.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> dateAndTime [
	"Answer the local dateAndTime of this data."

	^dateAndTimeUtc ifNotNil: [:dt | dt asLocal].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> dateAndTimeUtc [
	"Answer the dateAndTime of this data."

	^dateAndTimeUtc.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> dateParm: aDateOrString [
	"Set the date parameter."
	| theDate |

	theDate := aDateOrString isString ifTrue: [aDateOrString] ifFalse: [aDateOrString yyyymmdd].
	self parameters at: 'date' put: theDate.

]

{ #category : 'Parameters',
 #vaCategories : ['Parameters','Time Interval Parameters'] }
UnitedStatesAstronomicalApiCall >> daysTimeIntervalParm: anInt iterations: anInt2 [
	"Set the time interval parameter."

	self timeIntervalParm: anInt iterations: anInt2 units: 'days'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> eraAD [
	"Set the era parameter to AD."

	self eraParm: 'AD'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> eraBC [
	"Set the era parameter to BC."

	self eraParm: 'BC'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> eraParm: aString [
	"Set the era parameter."

	self parameters at: 'era' put: aString.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> error [
	"Answer the error value of the United States Astronomical Api."

	^resultTable notNil ifTrue: [resultTable at: 'error' ifAbsent: []] ifFalse: [].

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> europa [
	"Set the body parameter."

	self parameters at: 'body' put: 'europa'.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> ganymede [
	"Set the body parameter."

	self parameters at: 'body' put: 'ganymede'.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> geometry [
	"Answer the Geometry of the United States Astronomical Api."

	^resultTable notNil ifTrue: [resultTable at: 'geometry' ifAbsent: [Dictionary new]] ifFalse: [Dictionary new].

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> getLatitudeAndLongitudeParmFromInternetGuess [
	"Get the Latitude and Longitude for our IP address and use them as the location parm."
	| latitudeAndLongitude result |

	result := [[(SstUrl fromString: 'http://ipinfo.io/loc') fetch] whenTimeoutInMilliseconds: 20000 do: [:toSig |
		toSig exitWith: (SstError for: ExSstNonFatalError with: MxSSTG122)]
	] on: Error do: [:sig | sig exitWith: nil].
	(result notNil and: [result isSstError not]) ifTrue: [
		latitudeAndLongitude := result trimSeparators subStrings: $,.
		(latitudeAndLongitude notNil and: [latitudeAndLongitude size = 2]) ifTrue: [
			self latitudeParm: latitudeAndLongitude first longitudeParm: latitudeAndLongitude second.
		].
	].

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> heightParm: anIntOrString [
	"Set the height parameter."
	| theHeight |

	theHeight := anIntOrString isNumber ifTrue: [anIntOrString printString] ifFalse: [anIntOrString].
	self parameters at: 'height' put: theHeight.

]

{ #category : 'Parameters',
 #vaCategories : ['Parameters','Time Interval Parameters'] }
UnitedStatesAstronomicalApiCall >> hoursTimeIntervalParm: anInt iterations: anInt2 [
	"Set the time interval parameter."

	self timeIntervalParm: anInt iterations: anInt2 units: 'hours'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> id [
	"Answer the id used with the call to the United States Astronomical Api."

	id isNil ifTrue: [id := ''].
	^id.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> id: aString [
	"Set the id used with the call to the United States Astronomical Api."

	id := aString.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> idParm [
	"Answer the id parm used with the call to the United States Astronomical Api."

	^self id notEmpty ifTrue: ['ID=', id] ifFalse: [''].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> indentNeeded: aStream [
	"Answer true if our #printOn: needs to indent lines."

	^(aStream contents notEmpty and: [aStream contents last = Tab]).

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> io [
	"Set the body parameter."

	self parameters at: 'body' put: 'io'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> julianDateParm: aFloatOrString [
	"Set the julianDate parameter."
	| theJulianDate |

	theJulianDate := aFloatOrString isString ifTrue: [aFloatOrString] ifFalse: [aFloatOrString printString].
	self parameters at: 'jd' put: theJulianDate.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> jupiter [
	"Set the body parameter."

	self parameters at: 'body' put: 'jupiter'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> latitudeParm: latFloatOrString longitudeParm: longFloatOrString [
	"Set the location 'coords' parameter.  With the latitude and longitude values."
	| lStream |

	lStream := WriteStream on: (String new: 50).
	latFloatOrString isString
		ifTrue: [lStream nextPutAll: latFloatOrString]
		ifFalse: [latFloatOrString printOn: lStream].
	lStream nextPutAll: ',%20'.
	longFloatOrString isString
		ifTrue: [lStream nextPutAll: longFloatOrString]
		ifFalse: [longFloatOrString printOn: lStream].
	self parameters at: 'coords' put: lStream contents.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> mars [
	"Set the body parameter."

	self parameters at: 'body' put: 'mars'.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> mercury [
	"Set the body parameter."

	self parameters at: 'body' put: 'mercury'.

]

{ #category : 'Parameters',
 #vaCategories : ['Parameters','Time Interval Parameters'] }
UnitedStatesAstronomicalApiCall >> minutesTimeIntervalParm: anInt iterations: anInt2 [
	"Set the time interval parameter."

	self timeIntervalParm: anInt iterations: anInt2 units: 'minutes'.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> moon [
	"Set the body parameter."

	self parameters at: 'body' put: 'moon'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> numberOfPhasesParm: anIntOrString [
	"Set the number of phases parameter."
	| numberOfPhases |

	numberOfPhases := anIntOrString isString ifTrue: [anIntOrString] ifFalse: [anIntOrString printString].
	self parameters at: 'nump' put: numberOfPhases.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> parameters [
	"Answer the dictionary that contains the parameters of the data service being called
		in the United States Astronomical Api.  All keys and values are strings."

	parameters isNil ifTrue: [parameters := Dictionary new].
	^parameters.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> parameters: aDictionary [
	"Set the Dictionary that contains the parameters of the data service being called
		in the United States Astronomical Api.  All keys and values are strings."

	parameters := aDictionary.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> parametersString [
	"Answer the string of parameters from the dictionary that contains the parameters
		of the data service being called in the United States Astronomical Api.  All keys and values are strings."
	| parms first |

	first := true.
	parms := WriteStream on: (String new: 100).
	self parameters keysAndValuesDo: [:name :value |
		first not ifTrue: [parms nextPut: $&].
		first := false.
		parms nextPutAll: name; nextPut: $=; nextPutAll: value.
	].
	^parms contents.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> printOn: aStream [
	"Print our data on the stream."
	| geometry parms truncated error |

	aStream nextPutAll: 'Id: '; nextPutAll: self id; cr.
	aStream nextPutAll: 'Version: '; nextPutAll: self apiVersion; cr.
	aStream nextPutAll: 'Data Service: '; nextPutAll: self dataService; cr.
	aStream nextPutAll: 'Type: '; nextPutAll: self type; cr.
	dateAndTimeUtc notNil ifTrue: [
		aStream nextPutAll: 'Date And Time: '; nextPutAll: self dateAndTime printString;
		nextPutAll: ' ('; nextPutAll: dateAndTimeUtc printString; nextPutAll: ')'; cr.
	].
	error := self error.
	error notNil ifTrue: [aStream nextPutAll: 'Error: '; nextPutAll: error; cr].
	parms := self parameters.
	parms notEmpty ifTrue: [
		aStream nextPutAll: 'Parameters: '; cr.
		parms keysAndValuesDo: [:key :val | aStream tab; nextPutAll: key; nextPutAll: ': '; nextPutAll: val printString; cr].
	].
	geometry := self geometry.
	geometry notEmpty ifTrue: [
		aStream nextPutAll: 'Geometry: '; cr.
		geometry keysAndValuesDo: [:key :val | aStream tab; nextPutAll: key; nextPutAll: ': '; nextPutAll: val printString; cr].
	].
	truncated := self truncated.
	truncated notNil ifTrue: [aStream nextPutAll: 'Truncated: '; nextPutAll: truncated printString; cr].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> properties [
	"Answer the dictionary with the properties."

	^self resultTable at: 'properties' ifAbsent: [Dictionary new].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> resultTable [
	"Answer the resultTable of the call to the United States Astronomical Api."

	resultTable isNil ifTrue: [resultTable := Dictionary new].
	^resultTable.

]

{ #category : 'Parameters',
 #vaCategories : ['Parameters','Time Interval Parameters'] }
UnitedStatesAstronomicalApiCall >> secondsTimeIntervalParm: anInt iterations: anInt2 [
	"Set the time interval parameter."

	self timeIntervalParm: anInt iterations: anInt2 units: 'seconds'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> timeIntervalParm: anIntOrString iterations: anIntOrString2 units: aString [
	"Set the time interval parameter."
	| intvMag reps |

	intvMag := anIntOrString isString ifTrue: [anIntOrString] ifFalse: [anIntOrString printString].
	reps := anIntOrString2 isString ifTrue: [anIntOrString2] ifFalse: [anIntOrString2 printString].
	self parameters at: 'intv_mag' put: intvMag.
	self parameters at: 'reps' put: reps.
	self parameters at: 'intv_unit' put: aString.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> timeParm: aTimeOrDurationOrString [
	"Set the time parameter."
	| timeStream |

	timeStream := WriteStream on: (String new: 12).
	aTimeOrDurationOrString isString ifTrue: [timeStream nextPutAll: aTimeOrDurationOrString] ifFalse: [
		timeStream
			nextPutAll: (aTimeOrDurationOrString hours printPaddedWith: $0 to: 2); nextPut: $:;
			nextPutAll: (aTimeOrDurationOrString minutes printPaddedWith: $0 to: 2); nextPut: $:;
			nextPutAll: (aTimeOrDurationOrString seconds printPaddedWith: $0 to: 2); nextPut: $.;
			nextPutAll: (aTimeOrDurationOrString microseconds printPaddedWith: $0 to: 3).
	].
	self parameters at: 'time' put: timeStream contents.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> timeZoneParm: aStringOrInt [
	"Set the time zone parameter."
	| tzdb tzrs parm |

	parm := aStringOrInt isInteger ifTrue: [aStringOrInt printString] ifFalse: [
		tzdb := EsTimeZoneDatabase singleton.
		tzrs := tzdb loadDataFrom: aStringOrInt prefixPath: tzdb tzInfoDir.
		tzrs notNil ifTrue: [tzrs offset hours printString] ifFalse: [aStringOrInt].
	].
	self parameters at: 'tz' put: parm.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> truncated [
	"Answer true if the data returned was truncated, nil if no #truncated value was returned."

	^self properties at: 'truncated' ifAbsent: [].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> type [
	"Answer the type of the United States Astronomical Api."

	^resultTable notNil ifTrue: [resultTable at: 'type' ifAbsent: ['']] ifFalse: [''].

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> url [
	"Answer the url used to call the United States Astronomical Api."

	^url.

]

{ #category : 'Not categorized' }
UnitedStatesAstronomicalApiCall >> url: aString [
	"Set the url used to call the United States Astronomical Api."

	url := aString.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> venus [
	"Set the body parameter."

	self parameters at: 'body' put: 'venus'.

]

{ #category : 'Object-Body Parameters',
 #vaCategories : ['Object-Body Parameters','Parameters'] }
UnitedStatesAstronomicalApiCall >> venusRadar [
	"Set the body parameter."

	self parameters at: 'body' put: 'venus-radar'.

]

{ #category : 'Parameters' }
UnitedStatesAstronomicalApiCall >> yearParm: anIntOrString [
	"Set the year parameter."
	| theYear |

	theYear := anIntOrString isString ifTrue: [anIntOrString] ifFalse: [anIntOrString printString].
	self parameters at: 'year' put: theYear.

]
