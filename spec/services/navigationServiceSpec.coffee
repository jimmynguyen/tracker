describe "NavigationServiceSpec", ->
	navigationService = undefined
	$location = undefined

	beforeEach ->
		angular.mock.module "app.services"

	beforeEach angular.mock.inject (NavigationService, _$location_) ->
		navigationService = NavigationService
		$location = _$location_
		spyOn $location, "url"

	describe "when NavigationService.goToCategory()", ->
		categoryId = 0
		path = "/category/" + categoryId

		it "then redirect to \"" + path + "\"", () ->
			navigationService.goToCategory(categoryId)
			expect $location.url
				.toHaveBeenCalledWith(path)

	describe "when NavigationService.goToEntry()", ->
		categoryId = 0
		entryId = 0
		path = "/category/" + categoryId + "/entry/" + entryId

		it "then redirect to \"" + path + "\"", () ->
			navigationService.goToEntry(categoryId, entryId)
			expect $location.url
				.toHaveBeenCalledWith(path)

	describe "when NavigationService.goToHome()", ->
		path = "/home"

		it "then redirect to \"" + path + "\"", () ->
			navigationService.goToHome()
			expect $location.url
				.toHaveBeenCalledWith(path)

	describe "when NavigationService.goToLogin()", ->
		path = "/login"

		it "then redirect to \"" + path + "\"", () ->
			navigationService.goToLogin()
			expect $location.url
				.toHaveBeenCalledWith(path)
