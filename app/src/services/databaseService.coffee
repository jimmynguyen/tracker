"use strict"

angular.module "app.services"

.factory "DatabaseService", (firebaseConfig, CookieService, LoggingService, $firebaseArray) ->

	# initialize firebase app if it has not been initialized
	if firebase.apps.length is 0
		firebase.initializeApp firebaseConfig
		# TODO: update to only run the below if running in production mode. otherwise, it will error out in the console. not a big deal, but it's probably bad practice
		firebase.auth().signInAnonymously().catch (error) ->
			# handle errors
			LoggingService.error "error authenticating firebase app with code: " + error.code, error.message
			return
		firebase.auth().onAuthStateChanged (user) ->
			if user
				# user is signed in
				LoggingService.log "firebase authentication successful"
			else
				# user is signed out (this should never be called since we're using anonymous authentication)
				LoggingService.error "firebase authentication failed"
			return

	databaseService =
		login: (emailOrUsername, password, callback) ->
			users = $firebaseArray(firebase.database().ref().child(CookieService.keys.user))
			users.$loaded()
				.then ->
					isLoginSuccessful = users.some (user) ->
						if user.password is password and (user.username is emailOrUsername or user.email is emailOrUsername)
							CookieService.setUser $.extend true, {}, user
							return true
					callback(isLoginSuccessful)
					return
				.catch (error) ->
					LoggingService.error "error loading node 'user':", error
					callback(false)
					return

	databaseService
