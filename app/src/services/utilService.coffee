"use strict"

angular.module "app.services"

.factory "UtilService", (keys, CacheService) ->

	utilService =
		date:
			datenumToDate: (datenum) ->
				date = new Date()
				date.setTime(datenum)
				date
			dateToDatenum: (date) ->
				if date not instanceof Date
					date = new Date(date)
				date.getTime()
			padZero: (s) ->
				if s.length is 1 then "0" + s else s
			dateToString: (date) ->
				str = null
				if date?
					if date not instanceof Date
						date = new Date date
					m = utilService.date.padZero (date.getMonth() + 1).toString()
					d = utilService.date.padZero date.getDate().toString()
					y = date.getFullYear().toString()
					H = utilService.date.padZero date.getHours().toString()
					M = utilService.date.padZero date.getMinutes().toString()
					S = utilService.date.padZero date.getSeconds().toString()
					str = m + "/" + d + "/" + y + " " + H + ":" + M + ":" + S
				str
			isDateString: (dateStr) ->
				dateStr? and typeof dateStr is "string" and dateStr.match /^[0-9]{2}\/[0-9]{2}\/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$/
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
