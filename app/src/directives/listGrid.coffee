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
	link: (scope) ->
		setShowList = (showList) ->
			scope.showList = showList
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
						numFields = res.fields.length
						for field in scope.defaultFields
							if field.name is "id"
								res.fields.unshift field
							else if field.name is "last_updated"
								lastUpdatedField = angular.copy field
								lastUpdatedField.id = numFields+1
								lastUpdatedField.order = numFields+1
								res.fields.push lastUpdatedField
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
