describe "AuthenticationServiceTest", ->
	authenticationService = undefined
	cookieService = undefined
	databaseService = undefined

	beforeEach ->
		angular.mock.module "app.services"

	beforeEach angular.mock.inject (AuthenticationService, CookieService, DatabaseService) ->
		authenticationService = AuthenticationService
		cookieService = CookieService
		databaseService = DatabaseService

	describe "when AuthenticationService.isLoggedIn()", ->
		it "if user is not logged in, then return false", () ->
			spyOn cookieService, "getUser"
				.and.returnValue undefined
			expect authenticationService.isLoggedIn()
				.toBeFalsy()
			expect cookieService.getUser
				.toHaveBeenCalled()
		it "if user is logged in, then return true", () ->
			spyOn cookieService, "getUser"
				.and.returnValue {}
			expect authenticationService.isLoggedIn()
				.toBeTruthy()
				expect cookieService.getUser
					.toHaveBeenCalled()

	# describe "when AuthenticationService.login()", ->
	# 	it "if the user credentials are valid, then ", () ->
	# 		navigationService.goToEntry(categoryId, entryId)
	# 		expect $location.url
	# 			.toHaveBeenCalledWith(path)

	describe "when AuthenticationService.logout()", ->
		it "then the user should be logged out", () ->
			spyOn cookieService, "removeUser"
			authenticationService.logout()
			expect cookieService.removeUser
				.toHaveBeenCalled()
