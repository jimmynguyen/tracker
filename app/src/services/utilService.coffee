"use strict"

angular.module "app.services"

.factory "UtilService", (keys, CacheService, LoggingService) ->

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
			getFieldByOrder: (fields, order, copy) ->
				orderField = null
				for field in fields
					if field.order is order
						orderField = if copy then angular.copy field else field
						break
				orderField
			removeFieldByName: (fields, name) ->
				field = null
				for f, i in fields
					if f.name is name
						field = fields.splice(i, 1)[0]
						break
				field
		object:
			copyProperties: (src, dst) ->
				if src? and dst?
					for property of src
						dst[property] = src[property]
				return
			getNewField: (data, res) ->
				nextId = utilService.data.getNextId data
				field =
					id: nextId
					name: res.display_name.toLowerCase().replace(/[^0-9a-z ]/g, '').replace /\s/g, '_'
					order: nextId
					editable: true
					required: res.required? and res.required
					visible: true
				utilService.object.copyProperties res, field
				field
		data:
			setDataOrderByIndex: (data, indexOffset) ->
				for d, i in data
					d.order = i+indexOffset
				return
			getById: (data, id) ->
				datum = null
				for d, i in data
					if d.id is id
						datum = d
						break
				datum
			getIndexById: (data, id) ->
				ndx = null
				for d, i in data
					if d.id is id
						ndx = i
						break
				ndx
			deleteById: (data, id, fieldNames) ->
				ndx = utilService.data.getIndexById data, id
				if ndx?
					datum = data.splice(ndx, 1)[0]
					if fieldNames?
						for fieldName in fieldNames
							utilService.data.decrementFieldGreaterThanValue data, fieldName, datum[fieldName], 1
				return
			decrementFieldGreaterThanValue: (data, fieldName, value, decrementBy) ->
				decrementBy = if decrementBy? then decrementBy else 1
				for datum in data
					if datum[fieldName]? and value? and datum[fieldName] > value
						datum[fieldName] -= decrementBy
				return
			getIdMap: (data) ->
				map = {}
				for d in data
					map[d.id] = d
				map
			getNextId: (data) ->
				nextId = -1
				for d in data
					if d.id > nextId
						nextId = d.id
				if nextId is -1 then 1 else nextId+1
		callback:
			default: (src, errorCallback, successCallback, scope, scopeVariableToAssign, callScopeApply) ->
				(err, res) ->
					if err
						LoggingService.error src, err
						if errorCallback?
							errorCallback err, res
					else
						if scope? and scopeVariableToAssign?
							scope[scopeVariableToAssign] = res
						if callScopeApply? and callScopeApply
							scope.$apply()
						if successCallback?
							successCallback err, res
					return
			modal:
				catch: (src, nonErrorCallback) ->
					(err) ->
						if err isnt "cancel"
							LoggingService.error src, err
						else
							if nonErrorCallback?
								nonErrorCallback()
						return
			firebase:
				catch: (src, callback) ->
					(err) ->
						LoggingService.error src, err
						callback err, null

	utilService
