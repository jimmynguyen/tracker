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
	selectViewOption = (option) ->
		if option is "list"
			$scope.showList = true
		else if option is "grid"
			$scope.showList = false
		return
	initialize = ->
		isLoggedIn()
		getCategories()
		getCategoryDefinition()
		$scope.showList = true
		$scope.selectViewOption = selectViewOption
		return
	initialize()

	return
