"use strict"

angular.module "app.controllers"

.controller "HomeController", (
		$scope,
		$location,
		DatabaseService) ->
	console.log $location.path()
	$scope.mangas = []
	DatabaseService.getObjectsByName $scope, "mangas", "manga"
	return
