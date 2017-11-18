"use strict"

angular.module "app.services"

.factory "LoggingService", ($log) ->

	loggingService =
		log: (arg) ->
			$log.log arg
			return
		logWithObject: (arg1, arg2) ->
			$log.log arg1, arg2
			return
		error: (arg) ->
			$log.error arg
			return
		errorWithObject: (arg1, arg2) ->
			$log.error arg1, arg2
			return

	loggingService
