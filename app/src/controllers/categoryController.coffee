"use strict"

angular.module "app.controllers"

.controller "CategoryController", (
		$scope,
		LocationService) ->
	LocationService.logPath()
	return
