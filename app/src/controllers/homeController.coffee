"use strict"

angular.module "app.controllers"

.controller "HomeController", (DatabaseService, LocationService, LoggingService) ->

	LocationService.logPath()
	DatabaseService.login "jdoe", "password", (isLoginSuccessful) ->
		if isLoginSuccessful
			LoggingService.log "hip hip hurray"
		else
			LoggingService.log "f me"

	return
