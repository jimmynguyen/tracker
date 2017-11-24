"use strict"

angular.module "app.controllers"

.controller "HomeController", (AuthenticationService, DatabaseService, LocationService, LoggingService, $scope) ->

	LocationService.logPath()
	isLoggedIn = ->
		if not AuthenticationService.isLoggedIn()
			LocationService.goToLogin()
		return
	getCategories = ->
		DatabaseService.category.getAll (err, res) ->
			if err
				LoggingService.error "HomeController.getCategories()", null, err
			else
				$scope.categories = res
			return
		return
	getCategoryDefinition = ->
		DatabaseService.definition.getCategory (err, res) ->
			if err
				LoggingService.error "HomeController.getCategoryDefinition()", null, err
			else
				$scope.categoryDefinition = res
			return
		return
	initialize = ->
		isLoggedIn()
		getCategories()
		getCategoryDefinition()
		return
	initialize()

	return
