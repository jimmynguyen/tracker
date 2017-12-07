describe "NotificationServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (NotificationService, _toastr_) ->
			this.notificationService = NotificationService
			this.toastr= _toastr_
			return
		this.msg = "msg"
		this.title = "title"
		return
	describe "when NotificationService.success()", ->
		it "then create a success toast", ->
			spyOn this.toastr, "success"
			this.notificationService.success this.msg, this.title
			expect this.toastr.success
				.toHaveBeenCalledWith this.msg, this.title
			return
		return
	describe "when NotificationService.info()", ->
		it "then create an info toast", ->
			spyOn this.toastr, "info"
			this.notificationService.info this.msg, this.title
			expect this.toastr.info
				.toHaveBeenCalledWith this.msg, this.title
			return
		return
	describe "when NotificationService.error()", ->
		it "then create an error toast", ->
			spyOn this.toastr, "error"
			this.notificationService.error this.msg, this.title
			expect this.toastr.error
				.toHaveBeenCalledWith this.msg, this.title
			return
		return
	describe "when NotificationService.warning()", ->
		it "then create an warning toast", ->
			spyOn this.toastr, "warning"
			this.notificationService.warning this.msg, this.title
			expect this.toastr.warning
				.toHaveBeenCalledWith this.msg, this.title
			return
		return
	return
