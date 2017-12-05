"use strict"

angular.module "app.services"

.factory "MappingService", (keys, CacheService, UtilService) ->

	mappingService =
		arrayMapper:
			map: (obj, objDefinition) ->
				dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
				res = []
				for o in obj
					if objDefinition?
						r = {}
						for field in objDefinition
							if ["date","datetime"].indexOf(dataTypeIdMap[field.data_type_id].name) isnt -1
								r[field.name] = UtilService.date.datenumToDate o[field.name]
							else if ["field"].indexOf(dataTypeIdMap[field.data_type_id].name) isnt -1
								r[field.name] = mappingService.fieldMapper.map o[field.name], CacheService.get keys.system.definition.field
							else
								r[field.name] = o[field.name]
						if Object.keys(r).length isnt 0
							res.push r
					else if o.$value?
						res.push o.$value
					else
						r = {}
						for p of o
							if p.charAt(0) isnt "$"
								r[p] = o[p]
						if Object.keys(r).length isnt 0
							res.push r
				res
			reverseMap: (obj, objDefinition) ->
				dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
				res = []
				for o in obj
					if objDefinition?
						r = {}
						for field in objDefinition
							if ["date","datetime"].indexOf(dataTypeIdMap[field.data_type_id].name) isnt -1
								r[field.name] = o[field.name].getTime()
							else if ["field"].indexOf(dataTypeIdMap[field.data_type_id].name) isnt -1
								r[field.name] = mappingService.fieldMapper.reverseMap o[field.name], CacheService.get keys.system.definition.field
							else
								r[field.name] = o[field.name]
						if Object.keys(r).length isnt 0
							res.push r
					else if o.$value?
						res.push o.$value
					else
						r = {}
						for p of o
							if p.charAt(0) isnt "$"
								r[p] = o[p]
						if Object.keys(r).length isnt 0
							res.push r
				res
		objectMapper:
			map: (obj) ->
				res = {}
				for o in obj
					res[o.$id] = o.$value
				res
		fieldMapper:
			map: (obj, definition) ->
				dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
				definition = if definition? then definition else angular.copy obj
				res = []
				for o in obj
					r = {}
					for field in definition
						if ["date","datetime"].indexOf(dataTypeIdMap[field.data_type_id].name) isnt -1
							r[field.name] = UtilService.date.datenumToDate o[field.name]
						else
							r[field.name] = o[field.name]
					if Object.keys(r).length isnt 0
						res.push r
				res
			reverseMap: (obj, definition) ->
				dataTypeIdMap = CacheService.get keys.app.dataTypeIdMap
				definition = if definition? then definition else angular.copy obj
				res = []
				for o in obj
					r = {}
					for field in definition
						if ["date","datetime"].indexOf(dataTypeIdMap[field.data_type_id].name) isnt -1
							r[field.name] = o[field.name].getTime()
						else
							r[field.name] = o[field.name]
					if Object.keys(r).length isnt 0
						res.push r
				res
	mappingService
