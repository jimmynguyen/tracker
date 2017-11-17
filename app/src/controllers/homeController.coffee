"use strict"

angular.module "app.controllers"

.controller "HomeController", (
		$scope,
		DatabaseService,
		LocationService) ->
	LocationService.logPath()
	# $scope.mangas = []
	# DatabaseService.getObjectsByName $scope, "mangas", "manga"
	DatabaseService.login $scope, "isLoginSuccessful", null, "password"
	$scope.$watch "isLoginSuccessful", () ->
		if $scope.isLoginSuccessful
			console.log "hip hip hurray"
		else
			console.log "f me"
	return
