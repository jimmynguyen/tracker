"use strict"

angular.module "app.directives"

.directive "dropdownInput", (DatabaseService, LoggingService, ModalService, UtilService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/dropdownInput.html"
	scope:
		data: "="
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
			scope.data = UtilService.definition.initializeItemFields scope.data, scope.definition
			ModalService.showAddEditModal scope.definition, scope.data, scope.defaultFields, scope.defaultDataTypes, scope.userDataTypes, "Dropdown"
				.then (res) ->
					scope.data = res
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
