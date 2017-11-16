"use strict"

angular.module "app.controllers"

.controller "EntryController", (
		$scope,
		$location) ->
	console.log $location.path()
	return
