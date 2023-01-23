Package {
	#name : 'UnitedStatesAstronomicalApp',
	#vaPrerequisites : ['SstHttpsCommunications','STONVASTCoreApp'],
	#vaSubApplications : [
	{
		#condition : 'true',
		#subapps : [
			'UnitedStatesAstronomicalDataApp'
		]
	}
]
}
