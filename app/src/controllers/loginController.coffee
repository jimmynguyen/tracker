"use strict"

angular.module "app.controllers"

.controller "LoginController", (errorTypes, errors, firebaseErrorCodes, AuthenticationService, LocationService, NotificationService, UtilService, $scope) ->

	showLoginForm = ->
		$scope.isLogin = true
		return
	showRegisterForm = ->
		$scope.isLogin = false
		return
	login = ->
		errorCallback = (err, res) ->
			error = if err.code? then err.code else err
			if error is firebaseErrorCodes.login.INVALID_EMAIL or error is firebaseErrorCodes.login.USER_NOT_FOUND or error is errors.INVALID_EMAIL
				NotificationService.error errors.INVALID_EMAIL, errorTypes.AUTHENTICATION_ERROR
				# TODO: highlight email field
			else if error is firebaseErrorCodes.login.WRONG_PASSWORD or error is errors.INVALID_PASSWORD
				NotificationService.error errors.INVALID_PASSWORD, errorTypes.AUTHENTICATION_ERROR
				# TODO: highlight password field
			else if error is firebaseErrorCodes.login.USER_DISABLED
				NotificationService.error errors.USER_DISABLED, errorTypes.AUTHENTICATION_ERROR
				# TODO: post message about contacting admin
			else
				# This should never be called, but to be safe
				NotificationService.error error, errorTypes.AUTHENTICATION_ERROR
			return
		AuthenticationService.login $scope.form.login.email, $scope.form.login.password, UtilService.callback.default "LoginController.login()", errorCallback
		return
	register = ->
		# TODO: implement
		return
	initialize = ->
		if !AuthenticationService.isLoggedIn()
			$scope.form =
				login: {}
				register: {}
			$scope.isLogin = true
			$scope.login = login
			$scope.register = register
			$scope.showLoginForm = showLoginForm
			$scope.showRegisterForm = showRegisterForm
		return
	initialize()

	return
