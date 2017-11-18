describe "LoggingServiceTest", ->
	loggingService = undefined
	$log = undefined
	arg1 = "arg1"
	arg2 = "arg2"
	beforeEach ->
		angular.mock.module "app"
		angular.mock.module "app.services"
		angular.mock.inject (LoggingService, _$log_) ->
			loggingService = LoggingService
			$log = _$log_
			return
		return
	describe "when LoggingService.log()", ->
		beforeEach ->
			spyOn $log, "log"
		it "if there is one input, then log one input", ->
			loggingService.log arg1
			expect $log.log
				.toHaveBeenCalledWith arg1
			return
		it "if there is two inputs, then log two inputs", ->
			loggingService.logWithObject arg1, arg2
			expect $log.log
				.toHaveBeenCalledWith arg1, arg2
			return
		return
	describe "when LoggingService.error()", ->
		beforeEach ->
			spyOn $log, "error"
		it "if there is one input, then log one input", ->
			loggingService.error arg1
			expect $log.error
				.toHaveBeenCalledWith arg1
			return
		it "if there is two input, then log two inputs", ->
			loggingService.errorWithObject arg1, arg2
			expect $log.error
				.toHaveBeenCalledWith arg1, arg2
			return
		return
	return
