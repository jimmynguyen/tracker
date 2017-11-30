"use strict"

angular.module "app.controllers"

.controller "CategoryController", (keys, AuthenticationService, CacheService, DatabaseService, LocationService, LoggingService, $scope, $routeParams) ->

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
		category = CacheService.get keys.selected.category
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
				LoggingService.error "CategoryController.getDefaultFields()", null, err
			else
				$scope.defaultFields = res
			return
		return
	getDefaultDataTypes = ->
		DatabaseService.dataType.getAllDefault (err, res) ->
			if err
				LoggingService.error "CategoryController.getDefaultDataTypes()", null, err
			else
				$scope.defaultDataTypes = res
			return
		return
	getUserDataTypes = ->
		DatabaseService.dataType.getAllByUser (err, res) ->
			if err
				LoggingService.error "CategoryController.getUserDataTypes()", null, err
			else
				$scope.userDataTypes = res
			return
		return
	addEntry = (entry, callback) ->
		DatabaseService.entry.add entry, $scope.category.id, callback
		return
	editEntry = (entry, callback) ->
		DatabaseService.entry.update entry, $scope.category.id, callback
		return
	deleteEntry = (entry, callback) ->
		DatabaseService.entry.delete entry, $scope.category.id, callback
		return
	initialize = ->
		getEntries()
		getCategory()
		getDefaultFields()
		getDefaultDataTypes()
		getUserDataTypes()
		$scope.viewEntry = null
		$scope.addEntry = addEntry
		$scope.editEntry = editEntry
		$scope.deleteEntry = deleteEntry
		return
	initialize()
	return
