describe "CacheServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.module "app.constants"
		angular.mock.inject (CacheService, _keys_, _localStorageService_, _$cookies_) ->
			this.cacheService = CacheService
			this.keys = _keys_
			this.localStorageService = _localStorageService_
			this.$cookies = _$cookies_
			return
		return
	describe "when CacheService.getUser()", ->
		it "then get user", ->
			spyOn this.$cookies, "getObject"
			this.cacheService.getUser()
			expect this.$cookies.getObject
				.toHaveBeenCalledWith this.keys.user.accounts
			return
		return
	describe "when CacheService.setUser()", ->
		it "then set user", ->
			user = {}
			spyOn this.$cookies, "putObject"
			this.cacheService.setUser user
			expect this.$cookies.putObject
				.toHaveBeenCalledWith this.keys.user.accounts, user
			return
		return
	describe "when CacheService.removeUser()", ->
		it "then remove user", ->
			spyOn this.$cookies, "remove"
			this.cacheService.removeUser()
			expect this.$cookies.remove
				.toHaveBeenCalledWith this.keys.user.accounts
			return
		return
	describe "when CacheService.get()", ->
		it "then get from localStorageService", ->
			key = "key"
			obj = {}
			spyOn this.localStorageService, "get"
				.and.returnValue obj
			expect this.cacheService.get key
				.toBe obj
			expect this.localStorageService.get
				.toHaveBeenCalledWith key
			return
		return
	describe "when CacheService.set()", ->
		it "then set in localStorageService", ->
			key = "key"
			obj = {}
			spyOn this.localStorageService, "set"
			this.cacheService.set key, obj
			expect this.localStorageService.set
				.toHaveBeenCalledWith key, obj
			return
		return
	describe "when CacheService.remove()", ->
		it "then remove from localStorageService", ->
			key = "key"
			spyOn this.localStorageService, "remove"
			this.cacheService.remove key
			expect this.localStorageService.remove
				.toHaveBeenCalledWith key
			return
		return
	return
