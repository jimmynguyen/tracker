"use strict"

angular.module "app.services"

.factory "DatabaseService", ($firebaseArray) ->
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
		console.log "firebase authentication error with code: " + error.code
		console.log error.message
		return
	firebase.auth().onAuthStateChanged (user) ->
		if user
			# user is signed in
			isAnonymous = user.isAnonymous
			uid = user.uid
			console.log isAnonymous
			console.log uid
			console.log "firebase authentication successful"
		else
			# user is signed out (this should never be called since we're using anonymous authentication)
		return

	databaseService =
		getObjectsByName: (scope, field, name) ->
			scope[field] = $firebaseArray(firebase.database().ref().child(name))
			scope.$watch field, () ->
				console.log scope[field]
			return

	databaseService
