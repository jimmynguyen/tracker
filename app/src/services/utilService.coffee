"use strict"

angular.module "app.services"

.factory "UtilService", (keys, CacheService) ->

	utilService =
		date:
			datenumToDate: (datenum) ->
				date = null
				if datenum?
					date = new Date()
					date.setTime(datenum)
				date
			dateToDatenum: (date) ->
				datenum = null
				if date?
					if date not instanceof Date
						date = new Date(date)
					datenum = date.getTime()
				datenum
		definition:
			addDefaultFields: (fields, defaultFields) ->
				numFields = fields.length
				for field in defaultFields
					if field.name is "id"
						fields.unshift field
					else if field.name is "last_updated"
						lastUpdatedField = angular.copy field
						lastUpdatedField.id = numFields+1
						lastUpdatedField.order = numFields+1
						fields.push lastUpdatedField
				return fields
			deleteDefaultFields: (fields, defaultFields) ->
				for defaultField in defaultFields
					for field, ndx in angular.copy fields
						if field.name is defaultField.name
							fields.splice ndx, 1
							break
				return fields
			initializeItemFields: (item, fields) ->
				dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
				if not item?
					item = {}
				for field in fields
					if not item[field.name]?
						if dataTypeIdMap[field.data_type_id].name is "boolean"
							item[field.name] = false
						else if ["dropdown", "field"].indexOf(dataTypeIdMap[field.data_type_id].name) isnt -1
							item[field.name] = {}
						else if dataTypeIdMap[field.data_type_id].name is "array"
							item[field.name] = []
						else if dataTypeIdMap[field.data_type_id].name is "string"
							item[field.name] = null
				return item

	utilService
