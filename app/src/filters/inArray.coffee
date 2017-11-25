"use strict"

angular.module "app.filters"

.filter 'inArray', ($filter) ->

	inArrayFilter = (list, arrayFilter, element) ->
		if arrayFilter
			return $filter("filter") list, (listItem) ->
				arrayFilter.indexOf(listItem[element]) isnt -1

	inArrayFilter
