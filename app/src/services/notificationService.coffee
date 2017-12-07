"use strict"

angular.module "app.services"

.factory "NotificationService", (toastr) ->

	notificationService =
		success: (msg, title) ->
			toastr.success msg, title
			return
		info: (msg, title) ->
			toastr.info msg, title
			return
		error: (msg, title) ->
			toastr.error msg, title
			return
		warning: (msg, title) ->
			toastr.warning msg, title
			return

	notificationService
