"use strict"

angular.module "app.controllers"

.controller "CategoryController", (keys, AuthenticationService, CookieService, DatabaseService, LocationService, LoggingService, $scope, $routeParams) ->

	LocationService.logPath()
	AuthenticationService.isLoggedIn()
	getEntries = ->
		$scope.category = null
		$scope.$watch "category", ->
			for field in $scope.category.fields
				if field.order is 1
					$scope.entryOrderByField =
						display_name: field.display_name
						name: field.name
					break
			DatabaseService.entry.getAll $scope.category.id, (err, res) ->
				if err
					LoggingService.error "CategoryController.getEntries()", null, err
				else
					$scope.entries = res
				return
			return
		return
	getCategory = ->
		category = CookieService.get keys.selected.category
		if not category or category.id.toString() isnt $routeParams.categoryId
			DatabaseService.category.getById $routeParams.categoryId, (err, res) ->
				if err
					LoggingService.error "CategoryController.getCategory()", null, err
				else
					$scope.category = res
				return
		else
			$scope.category = category
		return
	getDefaultFields = ->
		DatabaseService.field.getAllDefault (err, res) ->
			if err
				LoggingService.error "HomeController.getDefaultFields()", null, err
			else
				$scope.defaultFields = res
			return
		return
	getDefaultDataTypes = ->
		DatabaseService.dataType.getAllDefault (err, res) ->
			if err
				LoggingService.error "HomeController.getDefaultDataTypes()", null, err
			else
				$scope.defaultDataTypes = res
			return
		return
	getUserDataTypes = ->
		DatabaseService.dataType.getAllByUser (err, res) ->
			if err
				LoggingService.error "HomeController.getUserDataTypes()", null, err
			else
				$scope.userDataTypes = res
			return
		return
	viewEntry = (entry) ->
		CookieService.set keys.selected.category, $scope.category
		CookieService.set keys.selected.entry, entry
		LocationService.goToEntry $scope.category.id, entry.id
		return
	initialize = ->
		getEntries()
		getCategory()
		getDefaultFields()
		getDefaultDataTypes()
		getUserDataTypes()
		$scope.viewEntry = viewEntry
		return
	initialize()
	return
