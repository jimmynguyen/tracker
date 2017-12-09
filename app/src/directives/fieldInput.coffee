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
					if not item?
						if not scope.data?
							scope.data = []
							scope.nextDatumId = 1
						else
							scope.nextDatumId = -1
							for datum in scope.data
								if datum.id > scope.nextDatumId
									scope.nextDatumId = datum.id
							scope.nextDatumId++
						res.id = scope.nextDatumId
						res.name = res.display_name.toLowerCase().replace(/[^0-9a-z ]/g, '').replace /\s/g, '_'
						res.order = scope.nextDatumId
						res.editable = true
						res.required = if res.required? then res.required else false
						res.visible = true
						scope.data.push res
					else
						UtilService.object.copyProperties res, item
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
