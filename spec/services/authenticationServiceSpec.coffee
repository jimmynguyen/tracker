describe "AuthenticationServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (AuthenticationService, _errors_, CookieService, DatabaseService) ->
			this.authenticationService = AuthenticationService
			this.cookieService = CookieService
			this.databaseService = DatabaseService
			this.errors = _errors_
			return
		return
	describe "when AuthenticationService.isLoggedIn()", ->
		it "if user is not logged in, then return false", ->
			spyOn this.cookieService, "getUser"
				.and.returnValue null
			expect this.authenticationService.isLoggedIn()
				.toBeFalsy()
			expect this.cookieService.getUser
				.toHaveBeenCalled()
			return
		it "if user is logged in, then return true", ->
			spyOn this.cookieService, "getUser"
				.and.returnValue {}
			expect this.authenticationService.isLoggedIn()
				.toBeTruthy()
			expect this.cookieService.getUser
				.toHaveBeenCalled()
			return
		return
	describe "when AuthenticationService.login()", ->
		beforeEach ->
			this.callback = jasmine.createSpy "callback"
		it "if the credentials are not valid, then the user should not be logged in", ->
			email = null
			password = null
			this.authenticationService.login email, password, this.callback
			expect this.callback
				.toHaveBeenCalledWith this.errors.INVALID_EMAIL_OR_PASSWORD, false
			return
		it "if the credentials are valid, then the user should be logged in", ->
			email = "emailOrUsername"
			password = "password"
			spyOn this.databaseService, "login"
			this.authenticationService.login email, password, this.callback
			expect this.databaseService.login
				.toHaveBeenCalledWith email, password, this.callback
			return
		return
	describe "when AuthenticationService.logout()", ->
		it "then the user should be logged out", ->
			spyOn this.cookieService, "removeUser"
			this.authenticationService.logout()
			expect this.cookieService.removeUser
				.toHaveBeenCalled()
			return
		return
	return
