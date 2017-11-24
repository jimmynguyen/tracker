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
		scope.dataOrderByField =
			display_name: "Name"
			name: "name"
		scope.reverseOrderBy = false
		scope.setShowList = (showList) ->
			scope.showList = showList
			return
		scope.setDataOrderByField = (field) ->
			scope.dataOrderByField.display_name = field.display_name
			scope.dataOrderByField.name = field.name
			scope.reverseOrderBy = false
			return
		scope.reverseDataOrderByField = ->
			if "-" is scope.dataOrderByField.name.charAt 0
				scope.dataOrderByField.name = scope.dataOrderByField.name.substr(1)
			else
				scope.dataOrderByField.name = "-" + scope.dataOrderByField.name
			return
		return
