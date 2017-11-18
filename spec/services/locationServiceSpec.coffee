describe "LocationServiceTest", ->
	locationService = undefined
	loggingService = undefined
	$location = undefined
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (LocationService, LoggingService, _$location_) ->
			locationService = LocationService
			loggingService = LoggingService
			$location = _$location_
			spyOn $location, "url"
			return
		return
	describe "when LocationService.goToCategory()", ->
		categoryId = 0
		path = "/category/" + categoryId
		it "then redirect to \"" + path + "\"", ->
			locationService.goToCategory categoryId
			expect $location.url
				.toHaveBeenCalledWith path
			return
		return
	describe "when LocationService.goToEntry()", ->
		categoryId = 0
		entryId = 0
		path = "/category/" + categoryId + "/entry/" + entryId
		it "then redirect to \"" + path + "\"", ->
			locationService.goToEntry categoryId, entryId
			expect $location.url
				.toHaveBeenCalledWith path
			return
		return
	describe "when LocationService.goToHome()", ->
		path = "/home"
		it "then redirect to \"" + path + "\"", ->
			locationService.goToHome()
			expect $location.url
				.toHaveBeenCalledWith path
			return
		return
	describe "when LocationService.goToLogin()", ->
		path = "/login"
		it "then redirect to \"" + path + "\"", ->
			locationService.goToLogin()
			expect $location.url
				.toHaveBeenCalledWith path
			return
		return
	describe "when LocationService.logPath()", ->
		it "then log the path", ->
			spyOn $location, "path"
				.and.returnValue "/path"
			spyOn loggingService, "log"
			locationService.logPath()
			expect loggingService.log
				.toHaveBeenCalledWith "path: /path"
			return
		return
	return
