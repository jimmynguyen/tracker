"use strict"

angular.module "app.services"

.factory "ModalService", ($uibModal) ->

	modalDefaults =
		backdrop: "static"
		keyboard: false
		modalFade: true
		templateUrl: "app/templates/modals/default.html"
	modalOptions =
		closeButtonText: "Close"
		actionButtonText: "OK"
		headerText: "Proceed?"
		bodyText: "Perform this action?"

	modalService =
		showAddEditModal: (fields, item, defaultFields, defaultDataTypes, userDataTypes, headerText) ->
			userDataTypeMap = {}
			for dataType in userDataTypes
				userDataTypeMap[dataType.name] = dataType
			customModalOptions =
				closeButtonText: "Cancel"
				actionButtonText: if item? then "Save changes" else "Add"
				headerText: headerText
				fields: fields
				defaultFields: defaultFields
				defaultFieldNames: defaultFields.map (field) ->
					field.name
				defaultDataTypes: defaultDataTypes
				userDataTypes: userDataTypes
				userDataTypeMap: userDataTypeMap
				dataTypes: defaultDataTypes
					.filter (dataType) -> ["array", "field"].indexOf(dataType) is -1
					.concat userDataTypes.map (dataType) ->
						dataType.name
				item: if item? then angular.copy(item) else {}
			customModalDefaults =
				templateUrl: "app/templates/modals/addEdit.html"
			modalService.showModal customModalDefaults, customModalOptions
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
