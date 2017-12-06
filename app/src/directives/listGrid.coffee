"use strict"

angular.module "app.directives"

.directive "listGrid", (ModalService, LoggingService) ->

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
		userDataTypes: "="
		dataTypeIdMap: "=datatypeIdMap"
	link: (scope) ->
		scope.showList = true
		scope.reverseOrderBy = false
		scope.setShowList = (showList) ->
			scope.showList = showList
			return
		scope.setDataOrderByField = (field) ->
			scope.dataOrderByField.display_name = field.display_name
			scope.dataOrderByField.name = field.name
			scope.reverseOrderBy = false
			return
		scope.reverseDataOrderByField = ->
			if "-" is scope.dataOrderByField.name.charAt 0
				scope.dataOrderByField.name = scope.dataOrderByField.name.substr(1)
			else
				scope.dataOrderByField.name = "-" + scope.dataOrderByField.name
			return
		scope.showAddEditModal = (item) ->
			if item? and item.fields?
				originalItem = angular.copy item
				# remove id and last_updated fields when editing
				fields = []
				for field in item.fields
					if field.name isnt "id" and field.name isnt "last_updated"
						fields.push field
				item.fields = fields
			ModalService.showAddEditModal scope.fields, item, scope.defaultFields, scope.defaultDataTypes, scope.userDataTypes, scope.name
				.then (res) ->
					if res.fields?
						# add id and last_updated fields after editing
						res.fields.push
							id: res.fields.length+1
							name: "last_updated"
							display_name: "Last Updated"
							data_type: "string"
							order: res.fields.length+1
							editable: false
							required: true
							visible: true
						res.fields.unshift
							id: 0
							name: "id"
							display_name: "Id"
							data_type: "number"
							order: 0
							editable: false
							required: true
							visible: false
					if item?
						for property of res
							item[property] = res[property]
						scope.editDatum res, (err, res) ->
							if err
								LoggingService.error "listGrid.editDatum()", null, err
							else
								scope.data = res
								scope.$apply()
							return
					else
						scope.addDatum res, (err, res) ->
							if err
								LoggingService.error "listGrid.addDatum()", null, err
							else
								scope.data = res
								scope.$apply()
							return
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "listGrid.showAddEditModal()", null, err
					else
						if originalItem?
							for property of originalItem
								item[property] = originalItem[property]
					return
			return
		scope.showDeleteModal = (item) ->
			ModalService.showDeleteModal item, scope.name
				.then ->
					scope.deleteDatum item, (err, res) ->
						if err
							LoggingService.error "listGrid.deleteDatum()", null, err
						else
							scope.data = res
							scope.$apply()
						return
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "listGrid.showDeleteModal", null, err
					return
			return
		return
