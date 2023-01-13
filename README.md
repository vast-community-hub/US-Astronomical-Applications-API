# US-Astronomical-Applications-API
A VA Smalltalk interface to the US Astronomical Applications API

The Astronomical Applications Department of the U.S. Naval Observatory has
services that answer queries for each of the areas listed below.

See [Astronomical Applications API](https://aa.usno.navy.mil/data/api)
for information about each API service.

This repo is a VA Smalltalk interface to the API service.  The application
(UnitedStatesAstronomicalApp) contains API calls for each of the services
listed below.

The classes make it easy to query the Astronomical Applications API
for the information it supplies.  They construct the URL to query the
service in question.  You must supply the parameters needed for each query.
The ...ApiCall classes construct the required URL with the parameters in it
as a string.  You supply the parameters as Smalltalk objects (or strings)
and they are converted to strings as needed.

There is a class comment for each class and the application class comment
has more information about the app.  It also has code snippets that you can
execute to see the parameters needed and the replies of the services and
the data classes where the returned information is stored.

* [Complete Sun and Moon Data for One Day](https://aa.usno.navy.mil/data/api#rstt)
* [Phases of the Moon](https://aa.usno.navy.mil/data/api#phase)
* [Earth's Seasons and Apsides](https://aa.usno.navy.mil/data/api#seasons)
* [Daylight Saving Time](https://aa.usno.navy.mil/data/api#dst_api)
* [Solar Eclipse Computer](https://aa.usno.navy.mil/data/api#soleclipse)
* [Selected Christian Observances](https://aa.usno.navy.mil/data/api#easter)
* [Selected Jewish Observances](https://aa.usno.navy.mil/data/api#passover)
* [Selected Islamic Observances](https://aa.usno.navy.mil/data/api#islamiccal)
* [Julian Date Converter](https://aa.usno.navy.mil/data/api#jdconv)
* [Celestial Navigation Data for Assumed Position and Time](https://aa.usno.navy.mil/data/api#celnav_api)
* [Sidereal Time](https://aa.usno.navy.mil/data/api#sidtime)
