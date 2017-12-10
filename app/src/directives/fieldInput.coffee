"use strict"

angular.module "app.directives"

.directive "fieldInput", (DatabaseService, ModalService, LoggingService, UtilService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/fieldInput.html"
	scope:
		data: "="
		defaultFields: "="
		defaultDataTypes: "="
	link: (scope) ->
		getFieldDefinition = ->
			DatabaseService.definition.getField UtilService.callback.default "fieldInput.getFieldDefinition()", null, null, scope, "fields"
			return
		showAddEditModal = (item) ->
			scope.orderField = UtilService.definition.removeFieldByName scope.fields, "order"
			ModalService.showAddEditModal scope.fields, item, scope.defaultFields, scope.defaultDataTypes, "Field"
				.then (res) ->
					if item?
						UtilService.object.copyProperties res, item
					else
						scope.data = if scope.data? then scope.data else []
						res = UtilService.object.getNewField scope.data, res
						scope.data.push res
					return
				.catch UtilService.callback.modal.catch "fieldInput.showAddEditModal()"
				.finally ->
					scope.fields.push scope.orderField
			return
		showDeleteModal = (item) ->
			ModalService.showDeleteModal item, "Field"
				.then ->
					UtilService.data.deleteById scope.data, item.id, ["id", "order"]
					return
				.catch  UtilService.callback.modal.catch "fieldInput.showDeleteModal()"
			return
		initialize = ->
			getFieldDefinition()
			scope.showAddEditModal = showAddEditModal
			scope.showDeleteModal = showDeleteModal
			scope.sortableOptions =
				stop: (e, ui) ->
					UtilService.data.setOrderByIndex scope.data, 1
					return
			return
		initialize()
		return
