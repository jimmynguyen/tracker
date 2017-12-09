"use strict"

angular.module "app.directives"

.directive "listGrid", (LoggingService, ModalService, UtilService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/listGrid.html"
	scope:
		name: "@"
		pluralName: "@"
		data: "="
		fields: "=datumDefinition"
		dataOrderByField: "=orderBy"
		viewDatum: "="
		addDatum: "="
		editDatum: "="
		deleteDatum: "="
		defaultFields: "="
		defaultDataTypes: "="
		allowGridView: "="
	link: (scope) ->
		setShowList = (showList) ->
			scope.showList = showList
			if showList
				scope.search = ""
			else
				scope.search =
					name: ""
			return
		setDataOrderByField = (field) ->
			scope.dataOrderByField.display_name = field.display_name
			scope.dataOrderByField.name = field.name
			scope.reverseOrderBy = false
			return
		reverseDataOrderByField = ->
			if "-" is scope.dataOrderByField.name.charAt 0
				scope.dataOrderByField.name = scope.dataOrderByField.name.substr(1)
			else
				scope.dataOrderByField.name = "-" + scope.dataOrderByField.name
			return
		showAddEditModal = (item) ->
			if item?
				item = UtilService.definition.initializeItemFields item, scope.fields
				originalItem = angular.copy item
				if item.fields?
					item.fields = UtilService.definition.deleteDefaultFields item.fields, scope.defaultFields
			ModalService.showAddEditModal scope.fields, item, scope.defaultFields, scope.defaultDataTypes, scope.name
				.then (res) ->
					if res.fields?
						res.fields = UtilService.definition.addDefaultFields res.fields, scope.defaultFields
					if item?
						UtilService.object.copyProperties res, item
						scope.editDatum res, UtilService.callback.default "listGrid.showAddEditModal()", null, null, scope, "data", true
					else
						scope.addDatum res, UtilService.callback.default "listGrid.showAddEditModal()", null, null, scope, "data", true
					return
				.catch UtilService.callback.modal.catch "listGrid.showAddEditModal()", ->
						if originalItem?
							UtilService.object.copyProperties originalItem, item
						return
			return
		showDeleteModal = (item) ->
			ModalService.showDeleteModal item, scope.name
				.then ->
					scope.deleteDatum item, UtilService.callback.default "listGrid.showAddEditModal()", null, null, scope, "data", true
					return
				.catch UtilService.callback.modal.catch "listGrid.showDeleteModal()"
			return
		initialize = ->
			scope.showList = true
			scope.reverseOrderBy = false
			scope.setShowList = setShowList
			scope.setDataOrderByField = setDataOrderByField
			scope.reverseDataOrderByField = reverseDataOrderByField
			scope.showAddEditModal = showAddEditModal
			scope.showDeleteModal = showDeleteModal
		initialize()
		return
