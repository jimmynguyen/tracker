"use strict"

angular.module "app.controllers"

.controller "CategoryController", (errors, keys, AuthenticationService, CacheService, DatabaseService, LocationService, LoggingService, UtilService, $scope, $routeParams) ->

	getEntries = ->
		$scope.category = null
		$scope.$watch "category", ->
			$scope.entryOrderByField = UtilService.definition.getFieldByOrder $scope.category.fields, 1, true
			DatabaseService.entry.getAll $scope.category.id, $scope.category.fields, UtilService.callback.default "CategoryController.getEntries()", null, null, $scope, "entries"
			return
		return
	getCategory = ->
		category = CacheService.get keys.selected.category
		if not category or category.id.toString() isnt $routeParams.categoryId
			DatabaseService.category.getById $routeParams.categoryId, UtilService.callback.default "CategoryController.getCategory()", null, null, $scope, "category"
		else
			$scope.category = category
		return
	getDefaultFields = ->
		DatabaseService.field.getAllDefault UtilService.callback.default "CategoryController.getDefaultFields()", null, null, $scope, "defaultFields"
		return
	getDefaultDataTypes = ->
		DatabaseService.dataType.getAllDefault UtilService.callback.default "CategoryController.getDefaultDataTypes()", null, null, $scope, "defaultDataTypes"
		return
	addEntry = (entry, callback) ->
		DatabaseService.entry.add $scope.category.id, entry, $scope.category.fields, callback
		return
	editEntry = (entry, callback) ->
		DatabaseService.entry.update $scope.category.id, entry, $scope.category.fields, callback
		return
	deleteEntry = (entry, callback) ->
		DatabaseService.entry.delete $scope.category.id, entry, callback
		return
	initialize = ->
		if AuthenticationService.isLoggedIn()
			DatabaseService.util.initialize $scope
			$scope.$watch "isDatabaseInitialized", ->
				getEntries()
				getCategory()
				getDefaultFields()
				getDefaultDataTypes()
				$scope.viewEntry = null
				$scope.addEntry = addEntry
				$scope.editEntry = editEntry
				$scope.deleteEntry = deleteEntry
		return
	initialize()

	return
