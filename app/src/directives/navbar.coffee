"use strict"

angular.module "app.directives"

.directive "navbar", ->

	restrict: "AE"
	templateUrl: "app/templates/directives/navbar.html"
	scope:
		route: "="
	link: (scope) ->
		return
