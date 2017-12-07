"use strict"

angular.module "app.services"

.config (localStorageServiceProvider) ->

	localStorageServiceProvider
		.setPrefix "app"
		.setNotify true, true

	return

.config (toastrConfig) ->

	angular.extend toastrConfig,
		autoDismiss: true
		containerId: 'toast-container'
		maxOpened: 0
		newestOnTop: true
		positionClass: 'toast-top-right'
		preventDuplicates: false
		preventOpenDuplicates: false
		target: 'body'

	return
