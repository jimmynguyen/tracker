"use strict"

angular.module "app.directives"

.factory "AuthenticationService", ($cookies, DatabaseService) ->
	_userKey = "USER";

	authenticationService =
		isLoggedIn : () ->
			_isLoggedIn = true
			if not $cookies.getObject(_userKey)
				_isLoggedIn = false
			_isLoggedIn
		login : (scope, field, emailOrUsername, password) ->
			DatabaseService.login(scope, field, emailOrUsername, password)
			return
		logout : () ->
			$cookies.remove(_userKey)
			return
	authenticationService
