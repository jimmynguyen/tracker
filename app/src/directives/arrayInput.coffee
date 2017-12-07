"use strict"

angular.module "app.directives"

.directive "arrayInput", ->

	restrict: "AE"
	templateUrl: "app/templates/directives/arrayInput.html"
	scope:
		values: "="
	link: (scope) ->
		addValue = ->
			scope.values.push ""
			return
		deleteValue = (ndx) ->
			scope.values.splice ndx, 1
			return
		initialize = ->
			scope.addValue = addValue
			scope.deleteValue = deleteValue
			return
		initialize()
		return
