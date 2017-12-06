"use strict"

angular.module "app.directives"

.directive "customInput", (keys, CacheService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/customInput.html"
	scope:
		field: "="
		item: "="
		defaultFields: "="
		defaultDataTypes: "="
		userDataTypes: "="
		allDataTypes: "="
	link: (scope) ->
		initialize = ->
			scope.dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
		initialize()
		return
