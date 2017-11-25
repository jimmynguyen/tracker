describe "AuthenticationServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (AuthenticationService, _errors_, CookieService, DatabaseService) ->
			this.authenticationService = AuthenticationService
			this.errors = _errors_
			this.cookieService = CookieService
			this.databaseService = DatabaseService
			return
		this.callback = jasmine.createSpy "callback"
		return
	# describe "when AuthenticationService.isLoggedIn()", ->
	# 	it "if user is not logged in, then return false", ->
	# 		spyOn this.cookieService, "getUser"
	# 			.and.returnValue null
	# 		expect this.authenticationService.isLoggedIn()
	# 			.toBeFalsy()
	# 		expect this.cookieService.getUser
	# 			.toHaveBeenCalled()
	# 		return
	# 	it "if user is logged in, then return true", ->
	# 		spyOn this.cookieService, "getUser"
	# 			.and.returnValue {}
	# 		expect this.authenticationService.isLoggedIn()
	# 			.toBeTruthy()
	# 		expect this.cookieService.getUser
	# 			.toHaveBeenCalled()
	# 		return
	# 	return
	# describe "when AuthenticationService.login()", ->
	# 	it "if the credentials are not valid, then the user should not be logged in", ->
	# 		email = null
	# 		password = null
	# 		this.authenticationService.login email, password, this.callback
	# 		expect this.callback
	# 			.toHaveBeenCalledWith this.errors.INVALID_EMAIL_OR_PASSWORD, false
	# 		return
	# 	it "if the credentials are valid, then the user should be logged in", ->
	# 		email = "email"
	# 		password = "password"
	# 		spyOn this.databaseService, "util"
	# 		spyOn this.databaseService.util, "login"
	# 		this.authenticationService.login email, password, this.callback
	# 		expect this.databaseService.util.login
	# 			.toHaveBeenCalledWith email, password, this.callback
	# 		return
	# 	return
	describe "when AuthenticationService.logout()", ->
		it "then the user should be logged out", ->
			spyOn this.cookieService, "removeUser"
			this.authenticationService.logout()
			expect this.cookieService.removeUser
				.toHaveBeenCalled()
			return
		return
	# describe "when AuthenticationService.signUp()", ->
	# 	it "if the credentials are not valid, then the user should not be signed up", ->
	# 		email = null
	# 		password = null
	# 		user = null
	# 		spyOn this.databaseService, "util"
	# 		spyOn this.databaseService.util, "signUp"
	# 		this.authenticationService.signUp email, password, user, this.callback
	# 		expect this.databaseService.util.signUp
	# 			.not.toHaveBeenCalled()
	# 		expect this.callback
	# 			.not.toHaveBeenCalled()
	# 		return
	# 	it "if the credentials are valid, then the user should be signed up", ->
	# 		email = "email"
	# 		password = "password"
	# 		user =
	# 			email: email
	# 			first_name: "first_name"
	# 			last_name: "last_name"
	# 			last_updated: "last_updated"
	# 		spyOn this.databaseService, "util"
	# 		spyOn this.databaseService.util, "signUp"
	# 		this.authenticationService.signUp email, password, user, this.callback
	# 		expect this.databaseService.util.signUp
	# 			.toHaveBeenCalled()
	# 		expect this.databaseService.util.signUp.calls.mostRecent().args[0]
	# 			.toBe email
	# 		expect this.databaseService.util.signUp.calls.mostRecent().args[1]
	# 			.toBe password
	# 		return
	# 	# TODO: write more tests
	# 	# 1. if credentials are valid, but email already used
	# 	# 2. if credentials are valid, and account is created
	# 	return
	return
