describe "CookieServiceTest", ->
	cookieService = undefined
	$cookies = undefined
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (CookieService, _$cookies_) ->
			cookieService = CookieService
			$cookies = _$cookies_
			return
		return
	describe "when CookieService.getUser()", ->
		it "then get user", ->
			spyOn cookieService, "getObject"
			cookieService.getUser()
			expect cookieService.getObject
				.toHaveBeenCalledWith cookieService.keys.user
			return
		return
	describe "when CookieService.setUser()", ->
		it "then set user", ->
			user = {}
			spyOn cookieService, "putObject"
			cookieService.setUser user
			expect cookieService.putObject
				.toHaveBeenCalledWith cookieService.keys.user, user
			return
		return
	describe "when CookieService.removeUser()", ->
		it "then remove user", ->
			spyOn cookieService, "remove"
			cookieService.removeUser()
			expect cookieService.remove
				.toHaveBeenCalledWith cookieService.keys.user
			return
		return
	describe "when CookieService.getObject()", ->
		it "then get object from $cookies", ->
			key = "key"
			obj = {}
			spyOn $cookies, "getObject"
				.and.returnValue obj
			expect cookieService.getObject key
				.toBe obj
			expect $cookies.getObject
				.toHaveBeenCalledWith key
			return
		return
	describe "when CookieService.putObject()", ->
		it "then put object in $cookies", ->
			key = "key"
			obj = {}
			spyOn $cookies, "putObject"
			cookieService.putObject key, obj
			expect $cookies.putObject
				.toHaveBeenCalledWith key, obj
			return
		return
	describe "when CookieService.remove()", ->
		it "then remove from $cookies", ->
			key = "key"
			spyOn $cookies, "remove"
			cookieService.remove key
			expect $cookies.remove
				.toHaveBeenCalledWith key
			return
		return
	return
