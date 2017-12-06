"use strict"

angular.module "app.controllers"

.controller "HomeController", (keys, AuthenticationService, CacheService, DatabaseService, LocationService, LoggingService, $scope) ->

	LocationService.logPath()
	AuthenticationService.isLoggedIn()
	DatabaseService.util.initialize (err) ->
		if err
			LoggingService.error "error during database initialization"
		else
			LoggingService.log "initialized DatabaseService"
		$scope.isDatabaseInitialized = true
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
		$scope.$watch "isDatabaseInitialized", ->
			getCategories()
			getCategoryDefinition()
			getDefaultFields()
			getDefaultDataTypes()
			getUserDataTypes()
			$scope.viewCategory = viewCategory
			$scope.addCategory = addCategory
			$scope.editCategory = editCategory
			$scope.deleteCategory = deleteCategory
			$scope.dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
		return
	initialize()

	return
