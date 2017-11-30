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
		showAddModal: (fields, defaultFields, defaultDataTypes, userDataTypes, headerText) ->
			userDataTypeMap = {}
			for dataType in userDataTypes
				userDataTypeMap[dataType.name] = dataType
			customModalOptions =
				closeButtonText: "Cancel"
				actionButtonText: "Add"
				headerText: headerText
				fields: fields
				defaultFields: defaultFields
				defaultFieldNames: defaultFields.map (field) ->
					field.name
				defaultDataTypes: defaultDataTypes
				userDataTypes: userDataTypes
				userDataTypeMap: userDataTypeMap
				item: {}
			console.log "defaultFieldNames", customModalOptions.defaultFieldNames
			console.log "defaultDataTypes", defaultDataTypes
			console.log "userDataTypes", customModalOptions.userDataTypeMap
			customModalDefaults =
				templateUrl: "app/templates/modals/add.html"
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
