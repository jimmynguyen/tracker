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
		defaultFields: "="
		defaultDataTypes: "="
		userDataTypes: "="
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
			headerText = (if item? then "Edit " else "Add ") + scope.name
			if item? and item.fields?
				originalItem = angular.copy item
				# remove id and last_updated fields when editing
				item.fields.shift()
				item.fields.pop()
				for field in item.fields
					field.id--
			ModalService.showAddEditModal scope.fields, item, scope.defaultFields, scope.defaultDataTypes, scope.userDataTypes, headerText
				.then (res) ->
					if res.fields?
						for field in res.fields
							field.id++
						res.fields.unshift
							id: 0
							name: "id"
							display_name: "Id"
							data_type: "number"
							order: 0
							editable: false
							required: true
							visible: false
						res.fields.push
							id: 1
							name: "last_updated"
							display_name: "Last Updated"
							data_type: "string"
							order: res.fields.length
							editable: false
							required: true
							visible: true
					if item?
						for property of res
							item[property] = res[property]
						scope.editDatum res
					else
						scope.addDatum res
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
		return
