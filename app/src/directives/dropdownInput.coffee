"use strict"

angular.module "app.directives"

.directive "dropdownInput", ->

	restrict: "AE"
	templateUrl: "app/templates/directives/dropdownInput.html"
	scope:
		dropdownData: "="
	link: (scope) ->
		showAddEditModal = ->
			return
		initialize = ->
			scope.showAddEditModal = showAddEditModal
			return
		initialize
		return
