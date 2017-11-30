"use strict"

angular.module "app.services"

.factory "CacheService", (keys, localStorageService, $cookies) ->

	cacheService =
		get: (key) ->
			localStorageService.get key
		set: (key, object) ->
			localStorageService.set key, object
			return
		remove: (key) ->
			localStorageService.remove key
			return
		getUser: ->
			$cookies.getObject keys.user.accounts
		setUser: (user) ->
			$cookies.putObject keys.user.accounts, user
			return
		removeUser: ->
			$cookies.remove keys.user.accounts
			return

	cacheService
