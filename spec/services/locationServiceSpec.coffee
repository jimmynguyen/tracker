describe "LocationServiceTest", ->
	locationService = undefined
	$location = undefined

	beforeEach ->
		angular.mock.module "app.services"

	beforeEach angular.mock.inject (LocationService, _$location_) ->
		locationService = LocationService
		$location = _$location_
		spyOn $location, "url"

	describe "when LocationService.goToCategory()", ->
		categoryId = 0
		path = "/category/" + categoryId

		it "then redirect to \"" + path + "\"", () ->
			locationService.goToCategory(categoryId)
			expect $location.url
				.toHaveBeenCalledWith(path)

	describe "when LocationService.goToEntry()", ->
		categoryId = 0
		entryId = 0
		path = "/category/" + categoryId + "/entry/" + entryId

		it "then redirect to \"" + path + "\"", () ->
			locationService.goToEntry(categoryId, entryId)
			expect $location.url
				.toHaveBeenCalledWith(path)

	describe "when LocationService.goToHome()", ->
		path = "/home"

		it "then redirect to \"" + path + "\"", () ->
			locationService.goToHome()
			expect $location.url
				.toHaveBeenCalledWith(path)

	describe "when LocationService.goToLogin()", ->
		path = "/login"

		it "then redirect to \"" + path + "\"", () ->
			locationService.goToLogin()
			expect $location.url
				.toHaveBeenCalledWith(path)
