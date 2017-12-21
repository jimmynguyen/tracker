"use strict"

angular.module "app.services"

.config (localStorageServiceProvider) ->

	StorageType =
		LOCAL_STORAGE: "localStorage"
		SESSION_STORAGE: "sessionStorage"

	localStorageServiceProvider
		.setStorageType StorageType.SESSION_STORAGE
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
