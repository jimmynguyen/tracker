"use strict"

angular.module "app.controllers"

.controller "SettingsController", (
		$scope,
		$location,
		DatabaseService) ->
	$scope.route = $location.path()
	$scope.mangas = []

	DatabaseService.getObjectsByName $scope, "mangas", "manga"

	return
