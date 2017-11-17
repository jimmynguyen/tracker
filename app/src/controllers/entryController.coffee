"use strict"

angular.module "app.controllers"

.controller "EntryController", (
		$scope,
		LocationService) ->
	LocationService.logPath()
	return
