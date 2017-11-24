"use strict"

angular.module "app.directives"

.directive "grid", () ->

	restrict: "AE"
	templateUrl: "app/templates/directives/grid.html"
	scope:
		data: "="
		fields: "=datumDefinition"
