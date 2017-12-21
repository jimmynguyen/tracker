"use strict"

angular.module "app.directives"

.directive "navbar", (keys, CacheService, LocationService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/navbar.html"
	scope:
		route: "="
		category: "="
	link: (scope) ->
		initialize = ->
			scope.goToHome = LocationService.goToHome
			scope.goToCategory = LocationService.goToCategory
		initialize()
		return
