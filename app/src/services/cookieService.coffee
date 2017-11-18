"use strict"

angular.module "app.services"

.factory "CookieService", ($cookies) ->

	cookieService =
		keys:
			user: "user"
			database: "database"
		getUser: ->
			cookieService.getObject cookieService.keys.user
		setUser: (user) ->
			cookieService.putObject cookieService.keys.user, user
			return
		removeUser: ->
			cookieService.remove cookieService.keys.user
			return
		getObject: (key) ->
			$cookies.getObject key
		putObject: (key, object) ->
			$cookies.putObject key, object
			return
		remove: (key) ->
			$cookies.remove key
			return

	cookieService
