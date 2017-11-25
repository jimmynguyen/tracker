"use strict"

angular.module "app.services"

.factory "MappingService", ->

	mappingService =
		defaultMapper:
			map: (obj) ->
				obj
		arrayMapper:
			map: (obj) ->
				res = []
				for o in obj
					res.push o.$value
				res
		objectMapper:
			map: (obj) ->
				res = {}
				for o in obj
					res[o.$id] = o.$value
				res

	mappingService
