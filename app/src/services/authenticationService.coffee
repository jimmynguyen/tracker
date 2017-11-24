"use strict"

angular.module "app.services"

.factory "AuthenticationService", (errors, CookieService, DatabaseService, LoggingService) ->

	authenticationService =
		isLoggedIn : ->
			_isLoggedIn = true
			if not CookieService.getUser()
				_isLoggedIn = false
			_isLoggedIn
		# login : (email, password, callback) ->
		# 	if email? and password?
		# 		DatabaseService.util.login email, password, callback
		# 	else
		# 		callback errors.INVALID_EMAIL_OR_PASSWORD, false
		# 	return
		logout : ->
			CookieService.removeUser()
			return
		# signUp : (email, password, user, callback) ->
		# 	if email? and password?
		# 		DatabaseService.util.signUp email, password
		# 			.then (firebaseUser) ->
		# 				user.id = firebaseUser.uid
		# 				DatabaseService.addUser user, callback
		# 		, (err, firebaseUser) ->
		# 			if err
		# 				LoggingService.error "AuthenticationService.signUp()", null, err
		# 				callback err, user
		# 			else
		# 			return
		# 	return

	authenticationService
