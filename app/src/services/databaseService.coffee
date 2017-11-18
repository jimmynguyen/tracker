"use strict"

angular.module "app.services"

.factory "DatabaseService", (CookieService, LoggingService, $firebaseArray) ->

	# initialize firebase app if it has not been initialized
	if firebase.apps.length is 0
		_config =
			apiKey: "AIzaSyC84FRJ5B4fs1ZqHwFjv7uhQ3rr3NaFJ-c"
			authDomain: "tracker-9c7c9.firebaseapp.com"
			databaseURL: "https://tracker-9c7c9.firebaseio.com"
			projectId: "tracker-9c7c9"
			storageBucket: "tracker-9c7c9.appspot.com"
			messagingSenderId: "542245163827"
		firebase.initializeApp _config
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
			users = $firebaseArray(firebase.database().ref().child('user'))
			users.$loaded()
				.then (_users) ->
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
