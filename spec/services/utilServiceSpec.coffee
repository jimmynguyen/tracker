describe "UtilServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (UtilService, _keys_, CacheService, LoggingService) ->
			this.utilService = UtilService
			this.keys= _keys_
			this.cacheService = CacheService
			this.loggingService = LoggingService
			return
		# source: https://coffeescript-cookbook.github.io/chapters/classes_and_objects/cloning
		this.clone = (obj) ->
			if not obj? or typeof obj isnt 'object'
				return obj

			if obj instanceof Date
				return new Date(obj.getTime())

			if obj instanceof RegExp
				flags = ''
				flags += 'g' if obj.global?
				flags += 'i' if obj.ignoreCase?
				flags += 'm' if obj.multiline?
				flags += 'y' if obj.sticky?
				return new RegExp(obj.source, flags)

			newInstance = new obj.constructor()

			for key of obj
				newInstance[key] = this.clone obj[key]

			return newInstance
		return
	###
	UtilService.date.datenumToDate
	###
	describe "when UtilService.date.datenumToDate()", ->
		it "if datenum is not valid, then return null", ->
			expect this.utilService.date.datenumToDate null
				.toBeNull()
			return
		it "if datenum is valid, then return date", ->
			datenum = new Date().getTime()
			date = this.utilService.date.datenumToDate datenum
			expect date.getTime()
				.toBe datenum
			return
		return
	###
	UtilService.date.dateToDatenum
	###
	describe "when UtilService.date.dateToDatenum()", ->
		it "if date is not valid, then return null", ->
			expect this.utilService.date.dateToDatenum null
				.toBeNull()
			return
		it "if date is valid date, then return datenum", ->
			date = new Date()
			datenum = this.utilService.date.dateToDatenum date
			expect datenum
				.toBe date.getTime()
			return
		it "if date is valid string, then return datenum", ->
			date = "01/01/2017"
			datenum = this.utilService.date.dateToDatenum date
			expect datenum
				.toBe new Date(date).getTime()
			return
		return
	###
	UtilService.definition.addDefaultFields
	###
	describe "when UtilService.definition.addDefaultFields()", ->
		beforeEach ->
			this.defaultFields = [
				{
					name: "id"
				},{
					name: "last_updated"
				}
			]
			return
		it "if fields is empty, then add default fields", ->
			fields = []
			fields = this.utilService.definition.addDefaultFields fields, this.defaultFields
			expect fields
				.not.toBeNull()
			expect fields.length
				.toBe this.defaultFields.length
			expect fields[0].name
				.toBe "id"
			expect fields[fields.length-1].name
				.toBe "last_updated"
			return
		it "if fields is not empty, then add default fields", ->
			fields = [
				{
					name: "name"
				}
			]
			numFields = fields.length
			fields = this.utilService.definition.addDefaultFields fields, this.defaultFields
			expect fields
				.not.toBeNull()
			expect fields.length
				.toBe this.defaultFields.length + numFields
			expect fields[0].name
				.toBe "id"
			expect fields[fields.length-1].name
				.toBe "last_updated"
			return
	###
	UtilService.definition.deleteDefaultFields
	###
	describe "when UtilService.definition.deleteDefaultFields()", ->
		beforeEach ->
			this.defaultFields = [
				{
					name: "id"
				},{
					name: "last_updated"
				}
			]
			return
		it "if fields is empty, then delete default fields", ->
			fields = []
			numFields = fields.length
			fields = this.utilService.definition.deleteDefaultFields fields, this.defaultFields
			expect fields
				.not.toBeNull()
			expect fields.length
				.toBe numFields
			return
		it "if fields is not empty, then delete default fields", ->
			fields = [
				{
					name: "id"
				},{
					name: "name"
				},{
					name: "last_updated"
				}
			]
			numFields = fields.length
			fields = this.utilService.definition.deleteDefaultFields fields, this.defaultFields
			expect fields
				.not.toBeNull()
			expect fields.length
				.toBe numFields - this.defaultFields.length
			return
		return
	###
	UtilService.definition.initializeItemFields
	###
	describe "when UtilService.definition.initializeItemFields()", ->
		beforeEach ->
			this.fields = [
				{
					name: "boolean"
					data_type_id: 0
				},{
					name: "dropdown"
					data_type_id: 1
				},{
					name: "field"
					data_type_id: 2
				},{
					name: "array"
					data_type_id: 3
				},{
					name: "string"
					data_type_id: 4
				},{
					name: "other"
					data_type_id: 5
				}
			]
			spyOn this.cacheService, "get"
				.and.returnValue
					0:
						name: "boolean"
					1:
						name: "dropdown"
					2:
						name: "field"
					3:
						name: "array"
					4:
						name: "string"
					5:
						name: "other"
			return
		it "if item is undefined, then initialize item fields", ->
			item = null
			item = this.utilService.definition.initializeItemFields item, this.fields
			expect this.cacheService.get
				.toHaveBeenCalledWith this.keys.app.dataTypeIdMap
			expect item
				.not.toBeNull()
			expect item.boolean
				.toBeFalsy()
			expect item.dropdown
				.toEqual {}
			expect item.field
				.toEqual {}
			expect item.array
				.toEqual []
			expect item.string
				.toBeNull()
			expect item.other
				.toBeUndefined()
			return
		it "if item is defined, then initialize item fields", ->
			item =
				boolean: true
				dropdown:
					values: []
				field:
					id: 0
				array: ["element"]
				string: "string"
				other: "other"
			originalItem = this.clone item
			item = this.utilService.definition.initializeItemFields item, this.fields
			expect this.cacheService.get
				.toHaveBeenCalledWith this.keys.app.dataTypeIdMap
			expect item
				.not.toBeNull()
			expect item.boolean
				.toEqual originalItem.boolean
			expect item.dropdown
				.toEqual originalItem.dropdown
			expect item.field
				.toEqual originalItem.field
			expect item.array
				.toEqual originalItem.array
			expect item.string
				.toEqual originalItem.string
			expect item.other
				.toEqual originalItem.other
			return
		return
	###
	UtilService.definition.getFieldByOrder
	###
	describe "when UtilService.definition.getFieldByOrder()", ->
		beforeEach ->
			this.fields = [
				{
					order: 0
				},{
					order: 1
				}
			]
			return
		it "if fields is empty, then return null", ->
			field = this.utilService.definition.getFieldByOrder []
			expect field
				.toBeNull()
			return
		it "if order is not in fields, then return null", ->
			field = this.utilService.definition.getFieldByOrder this.fields, 2, false
			expect field
				.toBeNull()
			return
		it "if copy is false, then return the field", ->
			field = this.utilService.definition.getFieldByOrder this.fields, 0, false
			expect field
				.not.toBeNull()
			expect field
				.toBe this.fields[0]
			return
		it "if copy is true, then return a clone of the field", ->
			field = this.utilService.definition.getFieldByOrder this.fields, 0, true
			expect field
				.not.toBeNull()
			expect field
				.not.toBe this.fields[0]
			expect field
				.toEqual this.fields[0]
			return
	###
	UtilService.definition.removeFieldByName
	###
	describe "when UtilService.definition.removeFieldByName()", ->
		beforeEach ->
			this.fields = [
				{
					name: "field1"
				},{
					name: "field2"
				}
			]
			return
		it "if fields is empty, then fields should not change and return null", ->
			fields = []
			numFields = fields.length
			field = this.utilService.definition.removeFieldByName fields
			expect fields.length
				.toBe numFields
			expect field
				.toBeNull()
			return
		it "if name is not in fields, then fields should not change and return null", ->
			numFields = this.fields.length
			field = this.utilService.definition.removeFieldByName this.fields, "field3"
			expect this.fields.length
				.toBe numFields
			expect field
				.toBeNull()
			return
		it "if name is in fields, then remove field from fields and return field", ->
			fieldName = "field1"
			numFields = this.fields.length
			field = this.utilService.definition.removeFieldByName this.fields, fieldName
			expect this.fields.length
				.toBe numFields-1
			expect field
				.not.toBeNull()
			expect field.name
				.toBe fieldName
			return
	###
	UtilService.object.copyProperties
	###
	describe "when UtilService.object.copyProperties()", ->
		beforeEach ->
			this.src =
				property1: "val1"
				property2: "val2"
			this.dst =
				property1: "val2"
			return
		it "if src is not valid, then do not copy properties", ->
			this.utilService.object.copyProperties null, this.dst
			expect this.dst.property1
				.toBe "val2"
			return
		it "if dst is not valid, then do not copy properties", ->
			this.utilService.object.copyProperties this.src, null
			expect this.src.property1
				.toBe "val1"
			expect this.src.property2
				.toBe "val2"
			return
		it "if valid, then copy properties", ->
			this.utilService.object.copyProperties this.src, this.dst
			expect this.dst.property1
				.toBe "val1"
			expect this.dst.property2
				.toBe "val2"
			return
	###
	UtilService.data.setDataOrderByIndex
	###
	describe "when UtilService.data.setDataOrderByIndex()", ->
		beforeEach ->
			this.data = [
				{
					order: 2
				},{
					order: 3
				}
			]
			return
		it "if valid, then set data order by index", ->
			this.utilService.data.setDataOrderByIndex this.data, 0
			expect this.data[0].order
				.toBe 0
			expect this.data[1].order
				.toBe 1
			return
	###
	UtilService.data.getById
	###
	describe "when UtilService.data.getById()", ->
		beforeEach ->
			this.data = [
				{
					id: 0
				},{
					id: 1
				}
			]
			return
		it "if data is empty, then return null", ->
			datum = this.utilService.data.getById [], 0
			expect datum
				.toBeNull()
			return
		it "if id is not in data, then return null", ->
			datum = this.utilService.data.getById this.data, 2
			expect datum
				.toBeNull()
			return
		it "if id is in data, then return datum", ->
			datum = this.utilService.data.getById this.data, 1
			expect datum
				.not.toBeNull()
			expect datum.id
				.toBe 1
			expect datum
				.toBe this.data[1]
			return
	###
	UtilService.data.getIndexById
	###
	describe "when UtilService.data.getIndexById()", ->
		beforeEach ->
			this.data = [
				{
					id: 0
				},{
					id: 1
				}
			]
			return
		it "if data is empty, then return null", ->
			index = this.utilService.data.getIndexById [], 0
			expect index
				.toBeNull()
			return
		it "if id is not in data, then return null", ->
			index = this.utilService.data.getIndexById this.data, 2
			expect index
				.toBeNull()
			return
		it "if id is in data, then return index", ->
			index = this.utilService.data.getIndexById this.data, 1
			expect index
				.toBe 1
			return
	###
	UtilService.data.deleteById
	###
	describe "when UtilService.data.deleteById()", ->
		beforeEach ->
			this.data = [
				{
					id: 0
					order: 2
				},{
					id: 1
					order: 1
				},{
					id: 2
					order:0
				}
			]
			this.fieldNames = ["id", "order"]
			spyOn this.utilService.data, "getIndexById"
				.and.callThrough()
			spyOn this.data, "splice"
				.and.callThrough()
			spyOn this.utilService.data, "decrementFieldGreaterThanValue"
				.and.callThrough()
			return
		it "if data is empty, then data should not be changed", ->
			data = []
			dataLength = data.length
			this.utilService.data.deleteById data, null, null
			expect this.utilService.data.getIndexById
				.toHaveBeenCalledWith data, null
			expect this.data.splice
				.not.toHaveBeenCalled()
			expect this.utilService.data.decrementFieldGreaterThanValue
				.not.toHaveBeenCalled()
			expect data.length
				.toBe dataLength
			return
		it "if id is not in data, then data should not be changed", ->
			dataLength = this.data.length
			this.utilService.data.deleteById this.data, 3, null
			expect this.utilService.data.getIndexById
				.toHaveBeenCalledWith this.data, 3
			expect this.data.splice
				.not.toHaveBeenCalled()
			expect this.utilService.data.decrementFieldGreaterThanValue
				.not.toHaveBeenCalled()
			expect this.data.length
				.toBe dataLength
			return
		it "if fieldNames is not valid, then datum should be deleted from data", ->
			dataLength = this.data.length
			this.utilService.data.deleteById this.data, 1, null
			expect this.utilService.data.getIndexById
				.toHaveBeenCalledWith this.data, 1
			expect this.data.splice
				.toHaveBeenCalledWith 1, 1
			expect this.utilService.data.decrementFieldGreaterThanValue
				.not.toHaveBeenCalled()
			expect this.data.length
				.toBe dataLength-1
			expect this.data[0]
				.toEqual
					id: 0
					order: 2
			expect this.data[1]
				.toEqual
					id: 2
					order: 0
			return
		it "if fieldNames is valid, then datum should be deleted from data and data should be updated based on fieldNames", ->
			dataLength = this.data.length
			this.utilService.data.deleteById this.data, 1, this.fieldNames
			expect this.utilService.data.getIndexById
				.toHaveBeenCalledWith this.data, 1
			expect this.data.splice
				.toHaveBeenCalledWith 1, 1
			expect this.utilService.data.decrementFieldGreaterThanValue
				.toHaveBeenCalledTimes this.fieldNames.length
			expect this.data.length
				.toBe dataLength-1
			expect this.data[0]
				.toEqual
					id: 0
					order: 1
			expect this.data[1]
				.toEqual
					id: 1
					order: 0
			return
	###
	UtilService.data.decrementFieldGreaterThanValue
	###
	describe "when UtilService.data.decrementFieldGreaterThanValue()", ->
		beforeEach ->
			this.data = [
				{
					id: 0
					order: 2
				},{
					id: 2
					order:0
				}
			]
			this.originalData = this.clone this.data
			this.fieldNames = ["id", "order"]
			return
		it "if data is empty, then data should not be changed", ->
			data = []
			dataLength = data.length
			this.utilService.data.decrementFieldGreaterThanValue data, null, null, null
			expect data.length
				.toBe dataLength
			return
		it "if fieldName is not in data, then data should not be changed", ->
			this.utilService.data.decrementFieldGreaterThanValue this.data, "name", null, null
			expect this.data
				.toEqual this.originalData
			return
		it "if value is not valid, then data should not be changed", ->
			this.utilService.data.decrementFieldGreaterThanValue this.data, "order", null, null
			expect this.data
				.toEqual this.originalData
			return
		it "if decrementBy is not valid, then data should be changed with default decrementBy 1", ->
			this.utilService.data.decrementFieldGreaterThanValue this.data, "order", 1, null
			expect this.data
				.not.toEqual this.originalData
			expect this.data[0]
				.toEqual
					id: 0
					order: 1
			expect this.data[1]
				.toEqual this.originalData[1]
			return
		it "if valid, then data should be changed with decrementBy", ->
			this.data[0].order++
			this.originalData[0].order++
			this.utilService.data.decrementFieldGreaterThanValue this.data, "order", 1, 2
			expect this.data
				.not.toEqual this.originalData
			expect this.data[0]
				.toEqual
					id: 0
					order: 1
			expect this.data[1]
				.toEqual this.originalData[1]
			return
	###
	UtilService.data.getIdMap
	###
	describe "when UtilService.data.getIdMap()", ->
		beforeEach ->
			this.data = [
				{
					id: 1
				},{
					id: 0
				}
			]
			return
		it "if data is empty, then return empty map", ->
			expect this.utilService.data.getIdMap []
				.toEqual {}
			return
		it "if valid, then return map", ->
			map = this.utilService.data.getIdMap this.data
			expect Object.keys(map).length
				.toBe this.data.length
			for datum in this.data
				expect map[datum.id]
					.toBe datum
			return
	###
	UtilService.callback.default
	###
	describe "when UtilService.callback.default()", ->
		beforeEach ->
			this.src = "src"
			this.errorCallback = jasmine.createSpy "errorCallback"
			this.successCallback = jasmine.createSpy "successCallback"
			this.scope = jasmine.createSpyObj "scope", ["$apply"]
			this.scopeVariableToAssign = "scopeVariableToAssign"
			this.err = "err"
			this.res = "res"
			spyOn this.loggingService, "error"
			return
		describe "with src", ->
			beforeEach ->
				this.callback = this.utilService.callback.default this.src
				return
			it "if error, then log error", ->
				this.callback this.err, this.res
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				return
			return
		describe "with src and errorCallback", ->
			beforeEach ->
				this.callback = this.utilService.callback.default this.src, this.errorCallback
				return
			it "if error, then log error", ->
				this.callback this.err, this.res
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				expect this.errorCallback
					.toHaveBeenCalledWith this.err, this.res
				return
			return
		describe "with src, errorCallback, and successCallback", ->
			beforeEach ->
				this.callback = this.utilService.callback.default this.src, this.errorCallback, this.successCallback
				return
			it "if error, then log error and call errorCallback", ->
				this.callback this.err, this.res
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				expect this.errorCallback
					.toHaveBeenCalledWith this.err, this.res
				return
			it "if not error, then call successCallback", ->
				this.callback null, this.res
				expect this.successCallback
					.toHaveBeenCalledWith null, this.res
				return
			return
		describe "with src, errorCallback, successCallback, and scope", ->
			beforeEach ->
				this.callback = this.utilService.callback.default this.src, this.errorCallback, this.successCallback, this.scope
				return
			it "if error, then log error and call errorCallback", ->
				this.callback this.err, this.res
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				expect this.errorCallback
					.toHaveBeenCalledWith this.err, this.res
				return
			it "if not error, then scope should not be changed and call successCallback", ->
				this.callback null, this.res
				originalScope = this.clone this.scope
				expect this.successCallback
					.toHaveBeenCalledWith null, this.res
				expect this.scope
					.toEqual originalScope
				return
			return
		describe "with src, errorCallback, successCallback, scope, and scopeVariableToAssign", ->
			beforeEach ->
				this.callback = this.utilService.callback.default this.src, this.errorCallback, this.successCallback, this.scope, this.scopeVariableToAssign
				return
			it "if error, then log error and call errorCallback", ->
				this.callback this.err, this.res
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				expect this.errorCallback
					.toHaveBeenCalledWith this.err, this.res
				return
			it "if not error, then scope should be changed and call successCallback", ->
				this.callback null, this.res
				expect this.successCallback
					.toHaveBeenCalledWith null, this.res
				expect this.scope[this.scopeVariableToAssign]
					.toEqual this.res
				return
			return
		describe "with src, errorCallback, successCallback, scope, scopeVariableToAssign, and callScopeApply", ->
			beforeEach ->
				this.callback = this.utilService.callback.default this.src, this.errorCallback, this.successCallback, this.scope, this.scopeVariableToAssign, true
				return
			it "if error, then log error and call errorCallback", ->
				this.callback this.err, this.res
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				expect this.errorCallback
					.toHaveBeenCalledWith this.err, this.res
				return
			it "if not error, then scope should be changed, call scope.$apply, and call successCallback", ->
				this.callback null, this.res
				expect this.successCallback
					.toHaveBeenCalledWith null, this.res
				expect this.scope[this.scopeVariableToAssign]
					.toEqual this.res
				expect this.scope.$apply
					.toHaveBeenCalled()
				return
			return
		return
	###
	UtilService.callback.modal.catch
	###
	describe "when UtilService.callback.modal.catch()", ->
		beforeEach ->
			this.src = "src"
			this.nonErrorCallback = jasmine.createSpy "nonErrorCallback"
			this.err = "err"
			spyOn this.loggingService, "error"
			return
		describe "with src", ->
			beforeEach ->
				this.callback = this.utilService.callback.modal.catch this.src
				return
			it "if error is not \"cancel\", then log error", ->
				this.callback this.err
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				return
			return
		describe "with src and nonErrorCallback", ->
			beforeEach ->
				this.callback = this.utilService.callback.modal.catch this.src, this.nonErrorCallback
				return
			it "if error is not \"cancel\", then log error", ->
				this.callback this.err
				expect this.loggingService.error
					.toHaveBeenCalledWith this.src, this.err
				return
			it "if error is \"cancel\", then call nonErrorCallback", ->
				this.callback "cancel"
				expect this.nonErrorCallback
					.toHaveBeenCalled()
				return
			return
	###
	UtilService.callback.firebase.catch
	###
	describe "when UtilService.callback.firebase.catch()", ->
		beforeEach ->
			this.src = "src"
			this.callback = jasmine.createSpy "callback"
			this.err = "err"
			spyOn this.loggingService, "error"
			return
		it "if valid, then log error and call callback", ->
			callback = this.utilService.callback.firebase.catch this.src, this.callback
			callback this.err
			expect this.loggingService.error
				.toHaveBeenCalledWith this.src, this.err
			expect this.callback
				.toHaveBeenCalledWith this.err, null
			return
		return
	return
