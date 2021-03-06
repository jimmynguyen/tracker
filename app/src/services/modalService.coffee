"use strict"

angular.module "app.services"

.factory "ModalService", (keys, CacheService, $uibModal) ->

	modalDefaults =
		backdrop: "static"
		keyboard: false
		modalFade: true
		templateUrl: "app/templates/modals/default.html"
	modalOptions =
		closeButtonText: "Cancel"
		bootstrapButtonClass: "btn-success"

	modalService =
		show: (customModalDefaults, customModalOptions) ->
			tempModalDefaults = {}
			tempModalOptions = {}
			angular.extend tempModalDefaults, modalDefaults, customModalDefaults
			angular.extend tempModalOptions, modalOptions, customModalOptions
			if not tempModalDefaults.controller
				tempModalDefaults.controller = ($scope, $uibModalInstance) ->
					$scope.modalOptions = tempModalOptions
					$scope.modalOptions.ok = (result) ->
						$uibModalInstance.close result
					$scope.modalOptions.close = (result) ->
						$uibModalInstance.dismiss "cancel"
			$uibModal.open(tempModalDefaults).result
		showModal: (customModalDefaults, customModalOptions) ->
			if not customModalDefaults
				customModalDefaults = {}
			if not customModalOptions
				customModalOptions = {}
			modalService.show customModalDefaults, customModalOptions
		showDeleteModal: (item, name) ->
			if not name?
				throw new Error "\"name\" cannot be undefined"
			customModalOptions =
				headerText: "Delete " + name
				actionButtonText: "Delete"
				bodyText: "Are you sure you want to delete " + (if item? and item.display_name? then "the " else "this ") + name.toLowerCase() + (if item? and item.display_name? then " \"" + item.display_name + "\"?" else "?")
				bootstrapButtonClass: "btn-danger"
			modalService.showModal {}, customModalOptions
		showAddEditModal: (fields, item, defaultFields, defaultDataTypes, name) ->
			customModalOptions =
				actionButtonText: if item? then "Save changes" else "Add"
				headerText: (if item? then "Edit " else "Add ") + name
				fields: fields
				defaultFields: defaultFields
				defaultDataTypes: defaultDataTypes
				dataTypeIdMap: CacheService.get keys.app.dataTypeIdMap
				item: if item? then angular.copy(item) else {}
			customModalDefaults =
				templateUrl: "app/templates/modals/addEdit.html"
			modalService.showModal customModalDefaults, customModalOptions

	modalService
