describe "CookieServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (CookieService, _$cookies_) ->
			this.cookieService = CookieService
			this.$cookies = _$cookies_
			return
		return
	describe "when CookieService.getUser()", ->
		it "then get user", ->
			spyOn this.cookieService, "getObject"
			this.cookieService.getUser()
			expect this.cookieService.getObject
				.toHaveBeenCalledWith this.cookieService.keys.user
			return
		return
	describe "when CookieService.setUser()", ->
		it "then set user", ->
			user = {}
			spyOn this.cookieService, "putObject"
			this.cookieService.setUser user
			expect this.cookieService.putObject
				.toHaveBeenCalledWith this.cookieService.keys.user, user
			return
		return
	describe "when CookieService.removeUser()", ->
		it "then remove user", ->
			spyOn this.cookieService, "remove"
			this.cookieService.removeUser()
			expect this.cookieService.remove
				.toHaveBeenCalledWith this.cookieService.keys.user
			return
		return
	describe "when CookieService.getObject()", ->
		it "then get object from $cookies", ->
			key = "key"
			obj = {}
			spyOn this.$cookies, "getObject"
				.and.returnValue obj
			expect this.cookieService.getObject key
				.toBe obj
			expect this.$cookies.getObject
				.toHaveBeenCalledWith key
			return
		return
	describe "when CookieService.putObject()", ->
		it "then put object in $cookies", ->
			key = "key"
			obj = {}
			spyOn this.$cookies, "putObject"
			this.cookieService.putObject key, obj
			expect this.$cookies.putObject
				.toHaveBeenCalledWith key, obj
			return
		return
	describe "when CookieService.remove()", ->
		it "then remove from $cookies", ->
			key = "key"
			spyOn this.$cookies, "remove"
			this.cookieService.remove key
			expect this.$cookies.remove
				.toHaveBeenCalledWith key
			return
		return
	return
