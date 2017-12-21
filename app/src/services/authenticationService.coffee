"use strict"

angular.module "app.services"

.factory "AuthenticationService", (errors, CacheService, DatabaseService, LocationService, LoggingService) ->

	authenticationService =
		isLoggedIn : ->
			isLoggedIn = false
			LocationService.logPath()
			if CacheService.getUser()?
				isLoggedIn = true
				if LocationService.isLogin()
					LocationService.goToHome()
			else
				if not LocationService.isLogin()
					LocationService.goToLogin()
			isLoggedIn
		login : (email, password, callback) ->
			if not email
				callback errors.INVALID_EMAIL, null
			else if not password
				callback errors.INVALID_PASSWORD, null
			else
				DatabaseService.authentication.login email, password, callback
			return
		logout : (callback) ->
			DatabaseService.authentication.logout callback
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
