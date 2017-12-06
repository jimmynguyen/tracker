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
		showAddEditModal: (fields, item, defaultFields, defaultDataTypes, userDataTypes, name) ->
			# userDataTypeMap = {}
			# for dataType in userDataTypes
			# 	userDataTypeMap[dataType.name] = dataType
			customModalOptions =
				actionButtonText: if item? then "Save changes" else "Add"
				headerText: (if item? then "Edit " else "Add ") + name
				fields: fields
				defaultFields: defaultFields
				defaultDataTypes: defaultDataTypes
				userDataTypes: userDataTypes
				dataTypeIdMap: CacheService.get keys.app.dataTypeIdMap
				# defaultFieldNames: defaultFields.map (field) ->
				# 	field.name
				# userDataTypeMap: userDataTypeMap
				# dataTypes: defaultDataTypes
				# 	.filter (dataType) -> ["array", "field"].indexOf(dataType) is -1
				# 	.concat userDataTypes.map (dataType) ->
				# 		dataType.name
				item: if item? then angular.copy(item) else {}
			customModalDefaults =
				templateUrl: "app/templates/modals/addEdit.html"
			modalService.showModal customModalDefaults, customModalOptions
		showDeleteModal: (item, name) ->
			customModalOptions =
				headerText: "Delete " + name
				closeButtonText: "Cancel"
				actionButtonText: "Delete"
				bodyText: "Are you sure you want to delete " + (if item.name? then "the " else "this ") + name.toLowerCase() + (if item.name? then " \"" + item.name + "\"?" else "?")
				bootstrapButtonClass: "btn-danger"
			modalService.showModal {}, customModalOptions
		showModal: (customModalDefaults, customModalOptions) ->
			if not customModalDefaults
				customModalDefaults = {}
			if not customModalOptions
				customModalOptions = {}
			modalService.show customModalDefaults, customModalOptions
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

	modalService
