"use strict"

angular.module "app.controllers"

.controller "HomeController", (errors, keys, AuthenticationService, CacheService, DatabaseService, LocationService, LoggingService, NotificationService, UtilService, $scope) ->

	getCategories = ->
		DatabaseService.category.getAll UtilService.callback.default "HomeController.getCategories()", null, null, $scope, "categories"
		return
	getCategoryDefinition = ->
		successCallback = (err, res) ->
			$scope.categoryOrderByField = UtilService.definition.getFieldByOrder $scope.categoryDefinition, 1, true
			return
		DatabaseService.definition.getCategory UtilService.callback.default "HomeController.getCategories()", null, successCallback, $scope, "categoryDefinition"
		return
	getDefaultFields = ->
		DatabaseService.field.getAllDefault UtilService.callback.default "HomeController.getDefaultFields()", null, null, $scope, "defaultFields"
		return
	getDefaultDataTypes = ->
		DatabaseService.dataType.getAllDefault UtilService.callback.default "HomeController.getDefaultDataTypes()", null, null, $scope, "defaultDataTypes"
		return
	viewCategory = (category) ->
		CacheService.set keys.selected.category, category
		LocationService.goToCategory category.id
		return
	addCategory = (category, callback) ->
		DatabaseService.category.add category, callback
		return
	editCategory = (category, callback) ->
		DatabaseService.category.update category, callback
		return
	deleteCategory = (category, callback) ->
		DatabaseService.category.delete category, callback
		return
	initialize = ->
		if AuthenticationService.isLoggedIn()
			DatabaseService.util.initialize $scope
			$scope.$watch "isDatabaseInitialized", ->
				getCategories()
				getCategoryDefinition()
				getDefaultFields()
				getDefaultDataTypes()
				$scope.viewCategory = viewCategory
				$scope.addCategory = addCategory
				$scope.editCategory = editCategory
				$scope.deleteCategory = deleteCategory
		return
	initialize()

	return
