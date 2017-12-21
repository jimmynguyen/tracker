"use strict"

angular.module "app.services"

.factory "LocationService", (LoggingService, $location, $timeout) ->

	locationService =
		isLogin: ->
			$location.path() is "/" or $location.path() is "/login"
		goToCategory: (categoryId) ->
			path = "/category/" + categoryId
			locationService.goToPath path
			return
		goToHome: ->
			locationService.goToPath "/home"
			return
		goToLogin: ->
			locationService.goToPath "/login"
			return
		goToPath: (path) ->
			$timeout ->
				$location.path path
		logPath: () ->
			LoggingService.log "path: " + $location.path()
			return

	locationService
