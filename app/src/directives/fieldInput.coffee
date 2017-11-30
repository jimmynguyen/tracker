"use strict"

angular.module "app.directives"

.directive "fieldInput", (DatabaseService, ModalService, LoggingService) ->

	restrict: "AE"
	templateUrl: "app/templates/directives/fieldInput.html"
	scope:
		data: "="
		defaultFields: "="
		defaultDataTypes: "="
		userDataTypes: "="
	link: (scope) ->
		getFieldDefinition = ->
			DatabaseService.definition.getField (err, res) ->
				if err
					LoggingService.error "fieldInput.getFieldDefinition()", null, err
				else
					scope.fields = res
				return
			return
		showAddModal = () ->
			for i in [scope.fields.length-1..0] by -1
				if scope.fields[i].name is 'order'
					scope.orderField = scope.fields.splice(i, 1)[0]
					break
			ModalService.showAddModal scope.fields, scope.defaultFields, scope.defaultDataTypes, scope.userDataTypes, "Add Field"
				.then (res) ->
					if not scope.data?
						scope.data = []
						scope.nextDatumId = 1
					if not scope.nextDatumId?
						scope.nextDatumId = -1
						for datum in scope.data
							if datum.id > scope.nextDatumId
								scope.nextDatumId = datum.id
					res.id = scope.nextDatumId
					res.name = res.display_name.toLowerCase().replace(/[^0-9a-z ]/g, '').replace /\s/g, '_'
					res.order = scope.nextDatumId
					res.editable = true
					res.required = if res.required? then res.required else false
					res.visible = true
					scope.nextDatumId++
					scope.data.push res
					scope.fields.push scope.orderField
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "fieldInput.showAddModal", null, err
					scope.fields.push scope.orderField
					return
			return
		initialize = ->
			getFieldDefinition()
			scope.nextDatumId = 0
			scope.showAddModal = showAddModal
			scope.sortableOptions =
				stop: (e, ui) ->
					for datum, ndx in scope.data
						datum.order = ndx+1
			return
		initialize()
