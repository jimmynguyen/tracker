"use strict"

angular.module "app.services"

.factory "MappingService", ->

	mappingService =
		arrayMapper:
			map: (obj) ->
				res = []
				for o in obj
					if o.$value?
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

	mappingService
