"use strict"

angular.module "app.services"

.config (localStorageServiceProvider) ->

	localStorageServiceProvider
		.setPrefix "app"
		.setNotify true, true

	return
