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
					LoggingService.error "fieldInput.getFieldDefinition()", err
				else
					scope.fields = res
				return
			return
		showAddEditModal = (item) ->
			for i in [scope.fields.length-1..0] by -1
				if scope.fields[i].name is 'order'
					scope.orderField = scope.fields.splice(i, 1)[0]
					break
			ModalService.showAddEditModal scope.fields, item, scope.defaultFields, scope.defaultDataTypes, scope.userDataTypes, "Field"
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
						for property of res
							item[property] = res[property]
					scope.fields.push scope.orderField
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "fieldInput.showAddEditModal()", err
					scope.fields.push scope.orderField
					return
			return
		showDeleteModal = (item) ->
			ModalService.showDeleteModal item, "Field"
				.then ->
					for datum, index in scope.data
						if datum.id is item.id
							datumIndex = index
							break
					scope.data.splice index, 1
					if scope.data.length-1 >= datumIndex
						for index in [datumIndex..scope.data.length-1]
							scope.data[index].id--
							scope.data[index].order--
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "fieldInput.showDeleteModal()", null, err
					return
			return
		initialize = ->
			getFieldDefinition()
			scope.showAddEditModal = showAddEditModal
			scope.showDeleteModal = showDeleteModal
			scope.sortableOptions =
				stop: (e, ui) ->
					for datum, ndx in scope.data
						datum.order = ndx+1
			return
		initialize()
		return
