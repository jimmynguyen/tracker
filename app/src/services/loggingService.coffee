"use strict"

angular.module "app.services"

.factory "LoggingService", ($log) ->

	loggingService =
		log: (arg) ->
			$log.log arg
			return
		error: (msg, err) ->
			$log.error msg, err
			return

	loggingService
