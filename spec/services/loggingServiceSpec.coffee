describe "LoggingServiceTest", ->
	beforeEach ->
		angular.mock.module "app"
		angular.mock.module "app.services"
		angular.mock.inject (LoggingService, _$log_) ->
			this.loggingService = LoggingService
			this.$log = _$log_
			return
		this.arg1 = "arg1"
		this.arg2 = "arg2"
		return
	describe "when LoggingService.log()", ->
		beforeEach ->
			spyOn this.$log, "log"
		it "if there is one input, then log one input", ->
			this.loggingService.log this.arg1
			expect this.$log.log
				.toHaveBeenCalledWith this.arg1
			return
		it "if there is two inputs, then log two inputs", ->
			this.loggingService.logWithObject this.arg1, this.arg2
			expect this.$log.log
				.toHaveBeenCalledWith this.arg1, this.arg2
			return
		return
	describe "when LoggingService.error()", ->
		beforeEach ->
			spyOn this.$log, "error"
		it "if there is one input, then log one input", ->
			this.loggingService.error this.arg1
			expect this.$log.error
				.toHaveBeenCalledWith this.arg1
			return
		it "if there is two input, then log two inputs", ->
			this.loggingService.errorWithObject this.arg1, this.arg2
			expect this.$log.error
				.toHaveBeenCalledWith this.arg1, this.arg2
			return
		return
	return
