describe "LocationServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (LocationService, LoggingService, _$location_) ->
			this.locationService = LocationService
			this.loggingService = LoggingService
			this.$location = _$location_
			spyOn this.$location, "url"
			return
		return
	describe "when LocationService.goToCategory()", ->
		categoryId = 0
		path = "/category/" + categoryId
		it "then redirect to \"" + path + "\"", ->
			this.locationService.goToCategory categoryId
			expect this.$location.url
				.toHaveBeenCalledWith path
			return
		return
	describe "when LocationService.goToHome()", ->
		path = "/home"
		it "then redirect to \"" + path + "\"", ->
			this.locationService.goToHome()
			expect this.$location.url
				.toHaveBeenCalledWith path
			return
		return
	describe "when LocationService.goToLogin()", ->
		path = "/login"
		it "then redirect to \"" + path + "\"", ->
			this.locationService.goToLogin()
			expect this.$location.url
				.toHaveBeenCalledWith path
			return
		return
	describe "when LocationService.logPath()", ->
		it "then log the path", ->
			spyOn this.$location, "path"
				.and.returnValue "/path"
			spyOn this.loggingService, "log"
			this.locationService.logPath()
			expect this.loggingService.log
				.toHaveBeenCalledWith "path: /path"
			return
		return
	return
