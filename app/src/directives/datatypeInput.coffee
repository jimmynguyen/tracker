"use strict"

angular.module "app.directives"

.directive "datatypeInput", ->

	restrict: "AE"
	templateUrl: "app/templates/directives/datatypeInput.html"
	scope:
		data: "="
		selectedDatum: "="
	link: (scope) ->
		return
