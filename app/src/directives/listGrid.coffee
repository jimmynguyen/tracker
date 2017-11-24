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
		scope.dataOrderByField =
			display_name: "Name"
			name: "name"
		scope.setDataOrderByField = (field) ->
			scope.dataOrderByField.display_name = field.display_name
			scope.dataOrderByField.name = field.name
			return
		scope.reverseOrderBy = false
		scope.reverseDataOrderByField = ->
			if "-" is scope.dataOrderByField.name.charAt 0
				scope.dataOrderByField.name = scope.dataOrderByField.name.substr(1)
			else
				scope.dataOrderByField.name = "-" + scope.dataOrderByField.name
			console.log scope.dataOrderByField
			return
		return
