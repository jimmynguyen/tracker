"use strict"

angular.module "app.services"

.factory "LocationService", ($location) ->
	locationService =
		logPath: () ->
			console.log $location.path()
		goToCategory: (categoryId) ->
			path = "/category/" + categoryId
			$location.url path
			return
		goToEntry: (categoryId, entryId) ->
			path = "/category/" + categoryId + "/entry/" + entryId
			$location.url path
			return
		goToHome: () ->
			$location.url "/home"
			return
		goToLogin: () ->
			$location.url "/login"
			return
	locationService
