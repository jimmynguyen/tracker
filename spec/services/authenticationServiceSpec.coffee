describe "AuthenticationServiceTest", ->
	authenticationService = undefined
	cookieService = undefined
	databaseService = undefined
	scope = undefined

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

	describe "when AuthenticationService.login()", ->
		beforeEach angular.mock.inject ($rootScope) ->
			scope = $rootScope.$new()
		it "then call DatabaseService.login()", () ->
			field = "isLoginSuccessful"
			emailOrUsername = "emailOrUsername"
			password = "password"
			spyOn databaseService, "login"
			authenticationService.login scope, field, emailOrUsername, password
			expect databaseService.login
				.toHaveBeenCalled()
			expect databaseService.login.calls.mostRecent().args[0]
				.toBe scope
			expect databaseService.login.calls.mostRecent().args[1]
				.toBe field
			expect databaseService.login.calls.mostRecent().args[2]
				.toBe emailOrUsername
			expect databaseService.login.calls.mostRecent().args[3]
				.toBe password

	describe "when AuthenticationService.logout()", ->
		it "then the user should be logged out", () ->
			spyOn cookieService, "removeUser"
			authenticationService.logout()
			expect cookieService.removeUser
				.toHaveBeenCalled()
