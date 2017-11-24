"use strict"

angular.module "app.directives"

.directive "listGrid", () ->

	restrict: "AE"
	templateUrl: "app/templates/directives/listGrid.html"
	scope:
		name: "@"
		data: "="
		fields: "=datumDefinition"
	link: (scope) ->
		scope.showList = true
		scope.setShowList = (showList) ->
			scope.showList = showList
