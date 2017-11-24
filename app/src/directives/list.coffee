"use strict"

angular.module "app.directives"

.directive "list", () ->

	restrict: "AE"
	templateUrl: "app/templates/directives/list.html"
	scope:
		data: "="
		fields: "=datumDefinition"
