describe "AuthenticationServiceTest", ->
	authenticationService = undefined
	cookieService = undefined
	databaseService = undefined
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (AuthenticationService, CookieService, DatabaseService) ->
			authenticationService = AuthenticationService
			cookieService = CookieService
			databaseService = DatabaseService
			return
		return
	describe "when AuthenticationService.isLoggedIn()", ->
		it "if user is not logged in, then return false", ->
			spyOn cookieService, "getUser"
				.and.returnValue undefined
			expect authenticationService.isLoggedIn()
				.toBeFalsy()
			expect cookieService.getUser
				.toHaveBeenCalled()
			return
		it "if user is logged in, then return true", ->
			spyOn cookieService, "getUser"
				.and.returnValue {}
			expect authenticationService.isLoggedIn()
				.toBeTruthy()
			expect cookieService.getUser
				.toHaveBeenCalled()
			return
		return
	describe "when AuthenticationService.login()", ->
		callback = undefined
		beforeEach ->
			callback = jasmine.createSpy("callback")
		it "if emailOrUsername or password is not valid, then the user should not be logged in", ->
			emailOrUsername = null
			password = null
			authenticationService.login emailOrUsername, password, callback
			expect callback
				.toHaveBeenCalledWith false
			return
		it "if emailOrUsername and password are valid, then the user should be logged in", ->
			emailOrUsername = "emailOrUsername"
			password = "password"
			spyOn databaseService, "login"
			authenticationService.login emailOrUsername, password, callback
			expect databaseService.login
				.toHaveBeenCalledWith emailOrUsername, password, callback
			return
		return
	describe "when AuthenticationService.logout()", ->
		it "then the user should be logged out", ->
			spyOn cookieService, "removeUser"
			authenticationService.logout()
			expect cookieService.removeUser
				.toHaveBeenCalled()
			return
		return
	return
