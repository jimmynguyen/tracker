"use strict"

angular.module "app.directives"

.directive "dropdownInput", (DatabaseService, LoggingService, ModalService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/dropdownInput.html"
	scope:
		dropdownData: "="
		defaultFields: "="
		defaultDataTypes: "="
		userDataTypes: "="
	link: (scope) ->
		getDropdownDefinition = ->
			DatabaseService.definition.getDropdown (err, res) ->
				if err
					LoggingService.error "dropdownInput.getDropdownDefinition()", err
				else
					scope.definition = res
				return
			return
		showAddEditModal = ->
			ModalService.showAddEditModal scope.definition, scope.dropdownData, scope.defaultFields, scope.defaultDataTypes, scope.userDataTypes, "Dropdown"
				.then (res) ->
					# TODO: implement
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "dropdownInput.showAddEditModal()", err
					return
			return
		initialize = ->
			getDropdownDefinition()
			scope.showAddEditModal = showAddEditModal
			return
		initialize()
		return
