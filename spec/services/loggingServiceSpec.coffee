describe "LoggingServiceTest", ->
	beforeEach ->
		angular.mock.module "app"
		angular.mock.module "app.services"
		angular.mock.inject (LoggingService, _$log_) ->
			this.loggingService = LoggingService
			this.$log = _$log_
			return
		this.msg = "msg"
		this.src = "src"
		this.key = "key"
		this.err = "err"
		return
	describe "when LoggingService.log()", ->
		beforeEach ->
			spyOn this.$log, "log"
		it "then log the message", ->
			this.loggingService.log this.msg
			expect this.$log.log
				.toHaveBeenCalledWith this.msg
			return
		return
	describe "when LoggingService.error()", ->
		beforeEach ->
			spyOn this.$log, "error"
		it "if there is no key, then log the error", ->
			this.loggingService.error this.msg, this.err
			expect this.$log.error
				.toHaveBeenCalledWith this.msg, this.err
			return
		return
	return
