"use strict"

angular.module "app.controllers"

.controller "CategoryController", (errors, keys, AuthenticationService, CacheService, DatabaseService, LocationService, LoggingService, $scope, $routeParams) ->

	getEntries = ->
		$scope.category = null
		$scope.$watch "category", ->
			for field in $scope.category.fields
				if field.order is 1
					$scope.entryOrderByField =
						display_name: field.display_name
						name: field.name
					break
			DatabaseService.entry.getAll $scope.category.id, $scope.category.fields, (err, res) ->
				if err
					LoggingService.error "CategoryController.getEntries()", err
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
					LoggingService.error "CategoryController.getCategory()", err
				else
					$scope.category = res
				return
		else
			$scope.category = category
		return
	getDefaultFields = ->
		DatabaseService.field.getAllDefault (err, res) ->
			if err
				LoggingService.error "CategoryController.getDefaultFields()", err
			else
				$scope.defaultFields = res
			return
		return
	getDefaultDataTypes = ->
		DatabaseService.dataType.getAllDefault (err, res) ->
			if err
				LoggingService.error "CategoryController.getDefaultDataTypes()", err
			else
				$scope.defaultDataTypes = res
			return
		return
	getUserDataTypes = ->
		DatabaseService.dataType.getAllByUser (err, res) ->
			if err
				LoggingService.error "CategoryController.getUserDataTypes()", err
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
		LocationService.logPath()
		AuthenticationService.isLoggedIn()
		DatabaseService.util.initialize (err) ->
			if err
				LoggingService.error errors.DATABASE_SERVICE_INITIALIZATION, err
			$scope.isDatabaseInitialized = true
			return
		$scope.$watch "isDatabaseInitialized", ->
			getEntries()
			getCategory()
			getDefaultFields()
			getDefaultDataTypes()
			getUserDataTypes()
			$scope.viewEntry = null
			$scope.addEntry = addEntry
			$scope.editEntry = editEntry
			$scope.deleteEntry = deleteEntry
			$scope.dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
		return
	initialize()

	return
