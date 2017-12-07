"use strict"

angular.module "app.filters"

.filter 'format', (keys, CacheService, $filter) ->

	formatFilter = (value, dataTypeId, isDataTypeField) ->
		dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
		dataType = dataTypeIdMap[dataTypeId].name
		formattedValue = value
		if value?
			if isDataTypeField
				formattedValue = dataTypeIdMap[value].display_name
			else if ["date", "datetime"].indexOf(dataType) isnt -1
				formattedValue = $filter("date")(value, "MM/dd/yyyy hh:mm:ss a")
			else if dataType is "boolean"
				formattedValue = if value then "Yes" else "No"
			else if dataType is "number"
				formattedValue = $filter("number")(value, 0)
			else if dataType is "dropdown"
				formattedValue = value.selectedValue
		formattedValue

	formatFilter
