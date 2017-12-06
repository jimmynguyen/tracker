"use strict"

angular.module "app.filters"

.filter 'format', ($filter) ->

	formatFilter = (value, dataType) ->
		formattedValue = value
		if ["date", "datetime"].indexOf(dataType) isnt -1
			formattedValue = $filter("date")(value, "MM/dd/yyyy hh:mm:ss a")
		else if dataType is "boolean"
			formattedValue = if value then "Yes" else "No"
		else if dataType is "number"
			formattedValue = $filter("number")(value, 0)
		formattedValue

	formatFilter
