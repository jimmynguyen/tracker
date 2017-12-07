describe "UtilServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (UtilService, CacheService, _keys_) ->
			this.utilService = UtilService
			this.cacheService = CacheService
			this.keys= _keys_
			return
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
			# source: https://coffeescript-cookbook.github.io/chapters/classes_and_objects/cloning
			clone = (obj) ->
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
					newInstance[key] = clone obj[key]

				return newInstance
			item =
				boolean: true
				dropdown:
					values: []
				field:
					id: 0
				array: ["element"]
				string: "string"
				other: "other"
			originalItem = clone item
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
	return
