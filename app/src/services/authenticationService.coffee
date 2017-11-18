"use strict"

angular.module "app.services"

.factory "AuthenticationService", (CookieService, DatabaseService) ->

	authenticationService =
		isLoggedIn : ->
			_isLoggedIn = true
			if not CookieService.getUser()
				_isLoggedIn = false
			_isLoggedIn
		login : (emailOrUsername, password, callback) ->
			if emailOrUsername? and password?
				DatabaseService.login emailOrUsername, password, callback
			else
				callback(false)
			return
		logout : ->
			CookieService.removeUser()
			return

	authenticationService
