describe "CookieServiceTest", ->
	cookieService = undefined
	$cookies = undefined

	beforeEach ->
		angular.mock.module "app.services"

	beforeEach angular.mock.inject (CookieService, _$cookies_) ->
		cookieService = CookieService
		$cookies = _$cookies_

	describe "when CookieService.getUser()", ->
		it "then get user", () ->
			spyOn cookieService, "getObject"
			cookieService.getUser()
			expect cookieService.getObject
				.toHaveBeenCalledWith cookieService.keys.user

	describe "when CookieService.setUser()", ->
		it "then set user", () ->
			user = {}
			spyOn cookieService, "putObject"
			cookieService.setUser user
			expect cookieService.putObject
				.toHaveBeenCalled()
			expect cookieService.putObject.calls.mostRecent().args[0]
				.toBe cookieService.keys.user
			expect cookieService.putObject.calls.mostRecent().args[1]
				.toBe user

	describe "when CookieService.removeUser()", ->
		it "then remove user", () ->
			spyOn cookieService, "remove"
			cookieService.removeUser()
			expect cookieService.remove
				.toHaveBeenCalled()
			expect cookieService.remove.calls.mostRecent().args[0]
				.toBe cookieService.keys.user

	describe "when CookieService.getObject()", ->
		it "then get object from $cookies", () ->
			key = "key"
			obj = {}
			spyOn $cookies, "getObject"
				.and.returnValue obj
			expect cookieService.getObject(key)
				.toBe obj
			expect $cookies.getObject
				.toHaveBeenCalled()
			expect $cookies.getObject.calls.mostRecent().args[0]
				.toBe key

	describe "when CookieService.putObject()", ->
		it "then put object in $cookies", () ->
			key = "key"
			obj = {}
			spyOn $cookies, "putObject"
			cookieService.putObject key, obj
			expect $cookies.putObject
				.toHaveBeenCalled()
			expect $cookies.putObject.calls.mostRecent().args[0]
				.toBe key
			expect $cookies.putObject.calls.mostRecent().args[1]
				.toBe obj

	describe "when CookieService.remove()", ->
		it "then remove from $cookies", () ->
			key = "key"
			spyOn $cookies, "remove"
			cookieService.remove key
			expect $cookies.remove
				.toHaveBeenCalled()
			expect $cookies.remove.calls.mostRecent().args[0]
				.toBe key


	# describe "when AuthenticationService.login()", ->
	# 	it "if the user credentials are valid, then ", () ->
	# 		navigationService.goToEntry(categoryId, entryId)
	# 		expect $location.url
	# 			.toHaveBeenCalledWith(path)

	# describe "when AuthenticationService.logout()", ->
	# 	it "then the user should be logged out", () ->
	# 		spyOn cookieService, "removeUser"
	# 		authenticationService.logout()
	# 		expect cookieService.removeUser
	# 			.toHaveBeenCalled()
