"use strict"

angular.module "app.directives"

.directive "navbar", (keys, AuthenticationService, CacheService, LocationService, UtilService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/navbar.html"
	scope:
		route: "="
		category: "="
	link: (scope) ->
		logout = ->
			AuthenticationService.logout UtilService.callback.default "navbar.logout()"
			return
		initialize = ->
			scope.goToHome = LocationService.goToHome
			scope.goToCategory = LocationService.goToCategory
			scope.logout = logout
		initialize()
		return
