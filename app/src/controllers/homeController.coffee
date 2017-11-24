"use strict"

angular.module "app.controllers"

.controller "HomeController", (CookieService, DatabaseService, LocationService, LoggingService, $scope) ->

	LocationService.logPath()
	email = "jdoe@fakemail.com"
	password = "johndoe"
	CookieService.removeAll()
	DatabaseService.util.logout ->
		DatabaseService.util.login email, password, (err, isLoginSuccessful) ->
			if err
				LoggingService.error "HomeController.login", email, err
			else
				if isLoginSuccessful
					DatabaseService.field.getAllDefault (err, objects) ->
						if err
							LoggingService.log "fuck"
						else
							$scope.objects = objects
							LoggingService.log $scope.objects
					LoggingService.log "login successful"
				else
					LoggingService.log "login failed"
			return
		return

	return
