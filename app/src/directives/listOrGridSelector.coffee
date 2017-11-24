"use strict"

angular.module "app.directives"

.directive "listOrGridSelector", () ->

	restrict: "AE"
	templateUrl: "app/templates/directives/listOrGridSelector.html"
	scope:
		showList: "="
		selectViewOption: "=onViewOptionChange"
