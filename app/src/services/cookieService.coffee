"use strict"

angular.module "app.services"

.factory "CookieService", (keys, $cookies) ->

	cookieService =
		get: (key) ->
			$cookies.getObject key
		set: (key, object) ->
			$cookies.putObject key, object
			return
		remove: (key) ->
			$cookies.remove key
			return
		getUser: ->
			cookieService.get keys.user
		setUser: (user) ->
			cookieService.set keys.user, user
			return
		removeUser: ->
			cookieService.remove keys.user
			return

	cookieService
