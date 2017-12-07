"use strict"

angular.module "app.controllers"

.controller "HomeController", (errors, keys, AuthenticationService, CacheService, DatabaseService, LocationService, LoggingService, $scope) ->

	getCategories = ->
		DatabaseService.category.getAll (err, res) ->
			if err
				LoggingService.error "HomeController.getCategories()", err
			else
				$scope.categories = res
			return
		return
	getCategoryDefinition = ->
		DatabaseService.definition.getCategory (err, res) ->
			if err
				LoggingService.error "HomeController.getCategoryDefinition()", err
			else
				$scope.categoryDefinition = res
				for field in $scope.categoryDefinition
					if field.order is 1
						$scope.categoryOrderByField =
							display_name: field.display_name
							name: field.name
						break
			return
		return
	getDefaultFields = ->
		DatabaseService.field.getAllDefault (err, res) ->
			if err
				LoggingService.error "HomeController.getDefaultFields()", err
			else
				$scope.defaultFields = res
			return
		return
	getDefaultDataTypes = ->
		DatabaseService.dataType.getAllDefault (err, res) ->
			if err
				LoggingService.error "HomeController.getDefaultDataTypes()", err
			else
				$scope.defaultDataTypes = res
			return
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
		LocationService.logPath()
		AuthenticationService.isLoggedIn()
		DatabaseService.util.initialize (err) ->
			if err
				LoggingService.error errors.DATABASE_SERVICE_INITIALIZATION, err
			$scope.isDatabaseInitialized = true
			return
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
