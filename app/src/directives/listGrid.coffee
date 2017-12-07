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
						for property of res
							item[property] = res[property]
						scope.editDatum res, (err, res) ->
							if err
								LoggingService.error "listGrid.showAddEditModal()", err
							else
								scope.data = res
								scope.$apply()
							return
					else
						scope.addDatum res, (err, res) ->
							if err
								LoggingService.error "listGrid.showAddEditModal()", err
							else
								scope.data = res
								scope.$apply()
							return
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "listGrid.showAddEditModal()", err
					else
						if originalItem?
							for property of originalItem
								item[property] = originalItem[property]
					return
			return
		showDeleteModal = (item) ->
			ModalService.showDeleteModal item, scope.name
				.then ->
					scope.deleteDatum item, (err, res) ->
						if err
							LoggingService.error "listGrid.showDeleteModal()", err
						else
							scope.data = res
							scope.$apply()
						return
					return
				.catch (err) ->
					if err isnt "cancel"
						LoggingService.error "listGrid.showDeleteModal", err
					return
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
