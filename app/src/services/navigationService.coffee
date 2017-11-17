"use strict"

angular.module "app.directives"

.factory "NavigationService", ($location) ->
	navigationService =
		goToCategory: (category_id) ->
			path = "/category/" + category_id
			$location.url path
			return
		goToEntry: (category_id, entry_id) ->
			path = "/category/" + category_id + "/entry/" + entry_id
			$location.url path
			return
		goToHome: () ->
			$location.url "/home"
			return
		goToLogin: () ->
			$location.url "/login"
			return
	navigationService
