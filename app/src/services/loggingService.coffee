"use strict"

angular.module "app.services"

.factory "LoggingService", ($log) ->

	loggingService =
		log: (arg) ->
			$log.log arg
			return
		error: (source, key, err) ->
			msg = "error in " + source
			msg += if key then " for key '" + key + "':" else ":"
			$log.error msg, err
			return

	loggingService
