"use strict"

angular.module "app.directives"

.directive "dropdownInput", (DatabaseService, LoggingService, ModalService, UtilService, $timeout) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/dropdownInput.html"
	scope:
		name: "="
		data: "="
		defaultFields: "="
		defaultDataTypes: "="
	link: (scope, element, attrs) ->
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
			ModalService.showAddEditModal scope.definition, scope.data, scope.defaultFields, scope.defaultDataTypes, "Dropdown"
				.then (res) ->
					scope.data = res
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "dropdownInput.showAddEditModal()", err
					return
				.finally ->
					scope.data.selectedValue = scope.oldSelectedValue
					scope.isAddEditModalShown = false
					$timeout ->
						$(scope.id).selectpicker("refresh")
					return
			return
		setUpSelectPicker = ->
			initializeSetupPicker = ->
				if scope.name? and scope.data?
					if not scope.data.selectedValue?
						scope.data.selectedValue = undefined
					scope.id = "select#selectpicker-#{scope.name}"
					$timeout ->
						$(scope.id).selectpicker()
						$(scope.id).on "shown.bs.select", (event, clickedIndex, newValue, oldValue) ->
							scope.oldSelectedValue = scope.data.selectedValue
							return
						$(scope.id).on "changed.bs.select", (event, clickedIndex, newValue, oldValue) ->
							if scope.data.selectedValue is "[Manage Values]" and not scope.isAddEditModalShown
								scope.isAddEditModalShown = true
								showAddEditModal()
							return
						return
				return
			scope.$watch scope.data, ->
				if not scope.data?
					scope.data = {}
				initializeSetupPicker()
			scope.$watch scope.name, initializeSetupPicker
			return
		initialize = ->
			getDropdownDefinition()
			setUpSelectPicker()
			scope.isAddEditModalShown = false
			return
		initialize()
		return
