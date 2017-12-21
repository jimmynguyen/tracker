describe "LocationServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (LocationService, LoggingService, _$location_, _$timeout_) ->
			this.locationService = LocationService
			this.loggingService = LoggingService
			this.$location = _$location_
			this.$timeout = _$timeout_
			return
		return
	###
	LocationService.isLogin
	###
	describe "when LocationService.isLogin()", ->
		it "if path is \"/\", then return true", ->
			spyOn this.$location, "path"
				.and.returnValue "/"
			expect this.locationService.isLogin()
				.toBeTruthy()
			expect this.$location.path
				.toHaveBeenCalledTimes 1
			return
		it "if path is \"/login\", then return true", ->
			spyOn this.$location, "path"
				.and.returnValue "/login"
			expect this.locationService.isLogin()
				.toBeTruthy()
			expect this.$location.path
				.toHaveBeenCalledTimes 2
			return
		it "if path is \"/home\", then return false", ->
			spyOn this.$location, "path"
				.and.returnValue "/home"
			expect this.locationService.isLogin()
				.toBeFalsy()
			expect this.$location.path
				.toHaveBeenCalledTimes 2
			return
		return
	###
	LocationService.goToCategory
	###
	describe "when LocationService.goToCategory()", ->
		categoryId = 0
		path = "/category/" + categoryId
		it "then redirect to \"" + path + "\"", ->
			spyOn this.locationService, "goToPath"
			this.locationService.goToCategory categoryId
			expect this.locationService.goToPath
				.toHaveBeenCalledWith path
			return
		return
	###
	LocationService.goToHome
	###
	describe "when LocationService.goToHome()", ->
		path = "/home"
		it "then redirect to \"" + path + "\"", ->
			spyOn this.locationService, "goToPath"
			this.locationService.goToHome()
			expect this.locationService.goToPath
				.toHaveBeenCalledWith path
			return
		return
	###
	LocationService.goToLogin
	###
	describe "when LocationService.goToLogin()", ->
		path = "/login"
		it "then redirect to \"" + path + "\"", ->
			spyOn this.locationService, "goToPath"
			this.locationService.goToLogin()
			expect this.locationService.goToPath
				.toHaveBeenCalledWith path
			return
		return
	###
	LocationService.goToPath
	###
	# TODO: implement
	###
	LocationService.logPath
	###
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
