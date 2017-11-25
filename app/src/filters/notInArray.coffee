"use strict"

angular.module "app.filters"

.filter 'notInArray', ($filter) ->

	notInArrayFilter = (list, arrayFilter, element) ->
		if arrayFilter
			return $filter("filter") list, (listItem) ->
				arrayFilter.indexOf(listItem[element]) is -1

	notInArrayFilter
