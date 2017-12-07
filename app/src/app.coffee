"use strict"

angular.module "app", [
	"app.routes"
	"app.controllers"
	"app.directives"
	"app.filters"
	"app.services"
]
angular.module "app.constants", []
angular.module "app.routes", [
	"ngRoute"
]
angular.module "app.controllers", []
angular.module "app.directives", [
	"ui.sortable"
]
angular.module "app.filters", []
angular.module "app.services", [
	"app.constants"
	"firebase"
	"LocalStorageModule"
	"ngAnimate"
	"ngCookies"
	"toastr"
	"ui.bootstrap"
]
