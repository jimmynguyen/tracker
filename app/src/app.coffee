"use strict"

angular.module "app", [
	"app.routes"
	"app.controllers"
	"app.directives"
	"app.filters"
	"app.services"
]
angular.module "app.config", []
angular.module "app.routes", [
	"ngRoute"
]
angular.module "app.controllers", []
angular.module "app.directives", []
angular.module "app.filters", []
angular.module "app.services", [
	"app.config"
	"firebase"
	"ngCookies"
]
