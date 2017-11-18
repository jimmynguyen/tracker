"use strict"

angular.module "app.controllers"

.controller "EntryController", (LocationService) ->

	LocationService.logPath()

	return
