"
Astronomical Applications Department of the U.S. Naval Observatory
This is a VA Smalltalk interface to the Astronomical Applications API v4.0.1
See https://aa.usno.navy.mil/data/api for information about each API service.

execute this: 'UnitedStatesAstronomicalApp comment' to get this comment as a string.

The U.S. Naval Observatory - Astronomical Applications API has services that answer
queries for each of the following:

Phases of the Moon
Complete Sun and Moon Data for One Day
Sidereal Time
Solar Eclipse Computer
Selected Christian Observances
Selected Jewish Observances
Selected Islamic Observances
Julian Date Converter
Earth's Seasons and Apsides
Daylight Saving Time
Celestial Navigation Data for Assumed Position and Time

This application (UnitedStatesAstronomicalApp) contains API calls for each of the above services.

The classes make it easy to query the Astronomical Applications API for the information it supplies.
They construct the URL to query the service in question.  You must supply the parameters needed for
each query.  The ...ApiCall classes construct the required URL with the parameters in it as a string.
You supply the parameters as Smalltalk objects (or strings) and they are converted to strings as needed.
Using Smalltalk objects for parameters is preferred.  Strings are allowed in case the proper string parameter
isn't created or to make it easier than creating a Smalltalk instance with a particular value, as I do in the
in some of the examples below.

The Astronomical Applications API answers separate UTC dates and times, this system saves them as UTC
but generally presents them as an instance of local date/time.  This keeps the date and time
together and allows you to do whatever you may like to do with a date and time.

The time values returned can contain fractions of a second.  They are of course returned as strings and
can look like: 12:15:23.1234.  Therefor the seconds part looks like a float.  If there are more than three (3) digits
to the right of the decimal, it represents microseconds and not milliseconds.  Our Time class is only accurate
to the millisecond.  To maintain the same level accuracy, I have created the USAUT1Time class.
It is a sub class of Duration.  I know this may seem odd but Time and Duration are very similar classes.
I use #doesNotUnderstand: to remove access to things like #days, that Time doesn't have.

I have also created the USADateAndTime class.  It is basically a copy of DateAndTime based on microseconds
and not milliseconds without a lot of the less valuable methods.  If a returned time value doesn't require microsecond
accuracy, the original Time and DateAndTime classes are used.  Calls to USAUT1Time class or
USADateAndTime class that should return a new instance, determine the accuracy required and return an instance
of USAUT1Time/Time or USADateAndTime/DateAndTime that maintains the required accuracy.

The following code builds and replaces this comment.  Don't run it unless you are sure you want to.
It reads this comment up to the line of *s, it then reads the class comments of the classes in this App
and constructs the rest of this comment and replaces it.

	| oldCommentStream newCommentStream commentHeader classes stars |

	oldCommentStream := ReadStream on: UnitedStatesAstronomicalApp comment.
	newCommentStream := WriteStream on: (String new: 10000).
	classes := {
		UnitedStatesAstronomicalApiCall.
			USAReplyData.
		USACelestialNavigationDataForAssumedPositionAndTimeApiCall.
			USACelestialNavigationData.
			USAAlmanacData.
			USAAltitudeCorrectionsData.
		USACompleteSunAndMoonDataForOneDayApiCall.
		USADaylightSavingTimeApiCall.
			USADaylightSavingTimeData.
		USAEarthSeasonsApiCall.
			USASeasonData.
		USAJulianGregorianDateConverterApiCall.
		USAGregorianToJulianDateConverterApiCall.
		USAJulianToGregorianDateConverterApiCall.
		USAMoonPhasesApiCall.
			USAMoonPhaseData.
		USAMoonPhasesDateApiCall.
		USAMoonPhasesYearApiCall.
		USAObservancesApiCall.
		USAChristianObservancesApiCall.
			USAChristianObservanceData.
		USAIslamicObservancesApiCall.
			USAIslamicObservanceData.
		USAJewishObservancesApiCall.
			USAJewishObservanceData.
		USASiderealTimeApiCall.
			USASiderealTimeData.
		USASolarEclipseCalculatorDateApiCall.
			USASolarEclipseLocalData.
		USASolarEclipseCalculatorYearApiCall.
			USAEclipseInYearData.
	}.
	stars := '*****', '*****', '*****', '*****', '*****', '*****', '*****'.
	commentHeader := oldCommentStream upToAll: stars.
	newCommentStream nextPutAll: commentHeader.
	newCommentStream nextPutAll: stars; cr.
	classes do: [:c | | cc |
		cc := ReadStream on: c comment.
		[cc atEnd] whileFalse: [ | line |
			line := cc nextLine.
			cc atEnd ifTrue: [
				(line notEmpty and: [line first ~= $-]) ifTrue: [newCommentStream nextPutAll: line; cr].
			] ifFalse: [
				(line isEmpty or: [line first ~= $-]) ifTrue: [newCommentStream nextPutAll: line; cr].
			].
		].
		newCommentStream cr.
	].

	UnitedStatesAstronomicalApp comment: newCommentStream contents.


Examples - Select snippets of code below and execute to see how the classes work.

***********************************

UnitedStatesAstronomicalApiCall is the super class of all USA...ApiCalls, as such doesn't get instantiated.

USAReplyData is the super class for all the data returned from the services.

	It has instances variables of:

	dateAndTimeUtc - an instance of DateAndTime or USADateAndTime if the returned data has both a date and time.
	value - if the returned data has only one value.
	date - a Date if there is a date in the returned data.
	time - a Time or USAUT1Time if there is a time in the returned data.

""Celestial Navigation Data for Assumed Position and Time"" see: https://aa.usno.navy.mil/data/api#celnav_api

	This data service provides all the astronomical information necessary to plot navigational lines
	of position from observations of the altitudes of celestial bodies.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/celnav

USACelestialNavigationDataForAssumedPositionAndTimeApiCall example:

	| us |
	us := USACelestialNavigationDataForAssumedPositionAndTimeApiCall new.
	us dateParm: '2021-08-30'.
	us timeParm: '16:11:00'.
	us latitudeParm: 36.8508 longitudeParm: -75.2859.
	us buildTheUrl; callTheApi.
	us inspect.

USACelestialNavigationData

USAAlmanacData

	dec - the declination in decimal degrees
	gha - the Greenwich Hour Angle in decimal degrees
	hc - the computed geocentric altitude in decimal degrees
	zn - the computed azimuth in decimal degrees

USAAltitudeCorrectionsData

	isCorrected - boolean that indicates if altitude corrections are displayed
	pa - the parallax in altitude in decimal degrees
	refr - the atmospheric refraction in decimal degrees
	sd - the semidiameter in decimal degrees
	sum - the sum of the other three altitude corrections in decimal degrees

""Complete Sun and Moon Data for One Day"" see: https://aa.usno.navy.mil/data/api#rstt

	This service supplies information about the sun and the moon like rise and set times for a given day.

	In this USACompleteSunAndMoonDataForOneDayApiCall example the date is supplied
	along with the latitude and longitude location guess from another internet server.  You can supply
	your own if you know it.

	| us |
	us := USACompleteSunAndMoonDataForOneDayApiCall new.
	us dateParm: Date today.
	us getLatitudeAndLongitudeParmFromInternetGuess.
	us buildTheUrl; callTheApi.
	us sunData inspect.
	us moonData inspect.
	us inspect.

""Daylight Saving Time"" see: https://aa.usno.navy.mil/data/api#dst_api

	This data service calculates the start and end dates for U.S.
	Daylight Saving Time for the years 1967 through 9999
	(assuming future years maintain the same rules for start and end dates).
	More information about this data service may be found at: https://aa.usno.navy.mil/data/daylight_time

USADaylightSavingTimeApiCall example:

	| us |
	us := USADaylightSavingTimeApiCall new.
	us yearParm: 1990.
	us buildTheUrl; callTheApi.
	us inspect.

	| us |
	us := USADaylightSavingTimeApiCall new.
	us yearParm: Date today year.
	us buildTheUrl; callTheApi.
	us inspect.

USADaylightSavingTimeData

	Holds the date and a description of the event.
	Has methods that return when daylight saving time begins and ends

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

USASeasonData

	data from USAEarthSeasonsApiCall

	Holds the date and a description of the event.
	Answers a symbol that describe the season.

USAJulianGregorianDateConverterApiCall is the super class of USAGregorianToJulianDateConverterApiCall
and USAJulianToGregorianDateConverterApiCall, as such doesn't get instantiated.
See: https://aa.usno.navy.mil/data/api#jdconv

	This data service converts dates between the Julian/Gregorian calendar and Julian date.
	Data will be provided for the years 4713 B.C. through A.D. 9999, or Julian dates of 0 through 5373484.5.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/JulianDate

USAGregorianToJulianDateConverterApiCall examples:

	| us |
	us := USAGregorianToJulianDateConverterApiCall new.
	us dateParm: '2013-08-03'.
	us timeParm: '22:15:23.5'.
	us buildTheUrl; callTheApi.
	us inspect.

	| us |
	us := USAGregorianToJulianDateConverterApiCall new.
	us dateParm: '4-3-26'.
	us timeParm: '2:3:0.0'.
	us eraBC.
	us buildTheUrl; callTheApi.
	us inspect.

USAJulianToGregorianDateConverterApiCall example:

	| us |
	us := USAJulianToGregorianDateConverterApiCall new.
	us julianDateParm: 2453124.1526.
	us buildTheUrl; callTheApi.
	us inspect.

""Phases of the Moon"" see: https://aa.usno.navy.mil/data/api#phase

	This data service generates a list of primary moon phases with their dates and times.
	The user may specify either the starting date for the list and the number of phases to calculate,
	or a calendar year for all phases during that year.
	The data can be produced for any year between 1700 and 2100 inclusive.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/MoonPhases

	This service supplies information about the phases of the moon.  The date/time and a brief
	description of the phase is supplied.

USAMoonPhasesApiCall is a super class of USAMoonPhasesYearApiCall and USAMoonPhasesDateApiCall,
as such doesn't get instantiated.

USAMoonPhaseData

	data from USACompleteSunAndMoonDataForOneDayApiCall

	Holds the date and a description of the event.
	Answers symbols that describe the phase of the moon.

USAMoonPhasesDateApiCall gets the phase information starting at given date, for a given number of phases.

	In this example a starting date and the number of phases desired are supplied.  The first day of the month
	and five (5) phases are asked for because that should get all the phases for the month (and maybe one more).

	| us |
	us := USAMoonPhasesDateApiCall new.
	us dateParm: Date today firstDayOfMonth.
	us numberOfPhasesParm: 5.
	us buildTheUrl; callTheApi.
	us phases inspect.
	us inspect.

USAMoonPhasesYearApiCall gets the phase information for every moon phase of a given year.

example:

	| us |
	us := USAMoonPhasesYearApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us phases inspect.
	us inspect.

USAObservancesApiCall is a super class of USAChristianObservancesApiCall, USAJewishObservancesApiCall
and USAIslamicObservancesApiCall, as such doesn't get instantiated.

""Selected Christian Observances"" see: https://aa.usno.navy.mil/data/api#easter

	This data service provides the dates of Ash Wednesday, Palm Sunday, Good Friday,
	Easter, Ascension Day, Whit Sunday, Trinity Sunday, and the First Sunday of Advent in a given year.
	Data will be provided for the years 1583 through 9999.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/christian_observances

USAChristianObservancesApiCall example:

	| us |
	us := USAChristianObservancesApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us observances inspect.
	us inspect.

USAChristianObservanceData

	Answers booleans as to the kind of observance like isEaster

""Selected Islamic Observances"" see: https://aa.usno.navy.mil/data/api#islamiccal

	This data service provides the dates for Islamic New Year, the first day of Ramadân,
	and the first day of Shawwál in a given year.
	Data will be provided for the years 622 C.E. (A.H. 1) through 9999 C.E. (A.H. 9666).
	No observances will be provided prior to A.H. 1 in 622 C.E..
	More information about this data service may be found at: https://aa.usno.navy.mil/data/islamic_observances

USAIslamicObservancesApiCall example:

	| us |
	us := USAIslamicObservancesApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us observances inspect.
	us inspect.

USAIslamicObservanceData

	islamicYear - the islamic year
	Answers booleans as to the kind of observance like isRamadan

""Selected Jewish Observances"" see: https://aa.usno.navy.mil/data/api#passover

	This data service provides the dates for Rosh Hashanah (Jewish New Year),
	Yom Kippur (Day of Atonement), first day of Succoth (Feast of Tabernacles),
	Hanukkah (Festival of Lights), first day of Pesach (Passover), and Shavuot (Feast of Weeks) in a given year.
	Data will be provided for the years 360 C.E. (A.M. 4120) through 9999 C.E. (A.M. 13761).
	More information about this data service may be found at: https://aa.usno.navy.mil/data/jewish_observances

USAJewishObservancesApiCall example:

	| us |
	us := USAJewishObservancesApiCall new.
	us yearParm: 2023.
	us buildTheUrl; callTheApi.
	us observances inspect.
	us inspect.

USAJewishObservanceData

	jewishYear - the jewish year
	Answers booleans as to the kind of observance like isHanukkah

""Sidereal Time"" see: https://aa.usno.navy.mil/data/api#sidtime

	This data service provides the Greenwich mean and apparent sidereal time,
	local mean and apparent sidereal time, and the Equation of the Equinoxes
	for date(s) and time(s) specified in UT1.

	Data will be provided for the years 1800 through 2050.

	This service requires a location, a date, and a time (in UT1).
	Time interval information is optional, if none is provided, then a single iteration will be returned.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/siderealtime

USASiderealTimeApiCall example:

	| us |
	us := USASiderealTimeApiCall new.
	us dateParm: '2020-03-04'.
	us latitudeParm: 41.89 longitudeParm: 12.48.
	us minutesTimeIntervalParm: 5 iterations: 90.
	us timeParm: '21:00:00'.
	us buildTheUrl; callTheApi.
	us inspect.

USASiderealTimeData

	eqofeq - equation of the equinoxes (seconds offset)
	gast - Greenwich apparent sidereal time
	gmst - Greenwich mean sidereal time
	last - local apparent sidereal time
	lmst - local mean sidereal time
	data - a dictionary with all the data
	ut1Time -  time in UT1

""Solar Eclipse Calculator"" see: https://aa.usno.navy.mil/data/api#soleclipse

	This data service provides local circumstances for solar eclipses,
	and also provides a means for determining dates and types of eclipses in a given year.

	For the local circumstances, data will be provided from 2017 through 2024.
	For dates outside of this range, see MICA at: https://aa.usno.navy.mil/software/mica_info

	This service requires a location and date, and may include height.
	More information about this data service may be found at: https://aa.usno.navy.mil/data/SolarEclipses

	For a list of eclipses in a selected year, data will be provided for 1800 through 2050.

USASolarEclipseCalculatorDateApiCall example:

	| us |
	us := USASolarEclipseCalculatorDateApiCall new.
	us getLatitudeAndLongitudeParmFromInternetGuess.
	us dateParm: '2017-8-21'.
	us heightParm: 15.
	us buildTheUrl; callTheApi.
	us inspect.

USASolarEclipseLocalData

	data from USASolarEclipseCalculatorDateApiCall

	time - time (given in UT1)
	altitude - the altiude of the Sun during this event
	azimuth - the azimuth of the Sun during this event
	day - the day of the month (some eclipses occur over two days in UT1)
	phenomenon - the name of the eclipse event
	positionAngle - the position angle of the event, not given for
	durationOfTotality - the duration of eclipse totality at this location, for locations where total eclipse occurs only
	vertexAngle - the vertex angle of the event, not given for maximum eclipse or sunrise/sunset

USASolarEclipseCalculatorYearApiCall example:

	| us |
	us := USASolarEclipseCalculatorYearApiCall new.
	us yearParm: 2017.
	us buildTheUrl; callTheApi.
	us eclipses inspect.
	us inspect.

USAEclipseInYearData

	data returned by USASolarEclipseCalculatorDateApiCall

	Holds the date and a description of the event.


"
Class {
	#name : 'UnitedStatesAstronomicalApp',
	#superclass : 'Application',
	#category : 'UnitedStatesAstronomicalApp'
}

{ #category : '-',
 #vaCategories : ['-','AbtEdit','AutoGen'],
  #vaVisibility : 'private' }
UnitedStatesAstronomicalApp class >> abtIsViewApplication [

	^false
]
