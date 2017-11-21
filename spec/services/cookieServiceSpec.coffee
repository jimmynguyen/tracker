describe "CookieServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.module "app.constants"
		angular.mock.inject (CookieService, _$cookies_, _keys_) ->
			this.cookieService = CookieService
			this.$cookies = _$cookies_
			this.keys = _keys_
			return
		return
	describe "when CookieService.getUser()", ->
		it "then get user", ->
			spyOn this.cookieService, "get"
			this.cookieService.getUser()
			expect this.cookieService.get
				.toHaveBeenCalledWith this.keys.user
			return
		return
	describe "when CookieService.setUser()", ->
		it "then set user", ->
			user = {}
			spyOn this.cookieService, "set"
			this.cookieService.setUser user
			expect this.cookieService.set
				.toHaveBeenCalledWith this.keys.user, user
			return
		return
	describe "when CookieService.removeUser()", ->
		it "then remove user", ->
			spyOn this.cookieService, "remove"
			this.cookieService.removeUser()
			expect this.cookieService.remove
				.toHaveBeenCalledWith this.keys.user
			return
		return
	describe "when CookieService.get()", ->
		it "then get object from $cookies", ->
			key = "key"
			obj = {}
			spyOn this.$cookies, "getObject"
				.and.returnValue obj
			expect this.cookieService.get key
				.toBe obj
			expect this.$cookies.getObject
				.toHaveBeenCalledWith key
			return
		return
	describe "when CookieService.set()", ->
		it "then put object in $cookies", ->
			key = "key"
			obj = {}
			spyOn this.$cookies, "putObject"
			this.cookieService.set key, obj
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
