"use strict"

angular.module "app.services"

.factory "AuthenticationService", (CookieService, DatabaseService) ->
	authenticationService =
		isLoggedIn : () ->
			_isLoggedIn = true
			if not CookieService.getUser()
				_isLoggedIn = false
			_isLoggedIn
		login : (scope, field, emailOrUsername, password) ->
			DatabaseService.login scope, field, emailOrUsername, password
			return
		logout : () ->
			CookieService.removeUser()
			return
	authenticationService
