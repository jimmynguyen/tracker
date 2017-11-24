"use strict"

angular.module "app.services"

.factory "MappingService", ->

	mappingService =
		account:
			map: (firebaseAccount) ->
				account = {}
				for property in firebaseAccount
					account[property.$id] = property.$value
				account
		default:
			map: (obj) ->
				obj

	mappingService
