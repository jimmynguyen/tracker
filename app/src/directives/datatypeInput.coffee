"use strict"

angular.module "app.directives"

.directive "datatypeInput", ->

	restrict: "AE"
	templateUrl: "app/templates/directives/datatypeInput.html"
	scope:
		name: "="
		dataTypes: "=datatypes"
		selectedDataTypeId: "="
	link: (scope) ->
		setUpSelectPicker = ->
			scope.$watch scope.selectedDataTypeId, ->
				if not scope.selectedDataTypeId?
					scope.selectedDataTypeId = undefined
				return
			scope.$watch scope.name, ->
				scope.id = "#selectpicker-#{scope.name}"
				$(scope.id).selectpicker()
				return
			return
		initialize = ->
			setUpSelectPicker()
			return
		initialize()
		return
