describe "ModalServiceTest", ->
	beforeEach ->
		angular.mock.module "app.services"
		angular.mock.inject (ModalService, _keys_, CacheService, _$uibModal_) ->
			this.modalService = ModalService
			this.keys = _keys_
			this.cacheService = CacheService
			this.$uibModal = _$uibModal_
			return
		return
	###
	ModalService.show
	###
	describe "when ModalService.show()", ->
		it "if valid, then show modal", ->
			spyOn this.$uibModal, "open"
				.and.returnValue
					result: null
			this.modalService.show {}, {}
			expect this.$uibModal.open
				.toHaveBeenCalled()
			return
		return
	###
	ModalService.showModal
	###
	describe "when ModalService.showModal()", ->
		beforeEach ->
			spyOn this.modalService, "show"
			return
		it "if invalid customModalDefaults, then show modal", ->
			this.modalService.showModal null, {}
			expect this.modalService.show
				.toHaveBeenCalled()
			return
		it "if invalid customModalOptions, then show modal", ->
			this.modalService.showModal {}, null
			expect this.modalService.show
				.toHaveBeenCalled()
			return
		it "if valid, then show modal", ->
			this.modalService.showModal {}, {}
			expect this.modalService.show
				.toHaveBeenCalled()
			return
		return
	###
	ModalService.showDeleteModal
	###
	describe "when ModalService.showDeleteModal()", ->
		beforeEach ->
			spyOn this.modalService, "showModal"
			this.item =
				display_name: "Display Name"
			this.name = "name"
			return
		it "if name is invalid, then throw error", ->
			expect this.modalService.showDeleteModal
				.toThrowError "\"name\" cannot be undefined"
			return
		it "if item is invalid, then show delete modal", ->
			this.modalService.showDeleteModal null, this.name
			expect this.modalService.showModal
				.toHaveBeenCalled()
			return
		it "if valid, then show delete modal", ->
			this.modalService.showDeleteModal this.item, this.name
			expect this.modalService.showModal
				.toHaveBeenCalled()
			return
		return
	###
	ModalService.showAddEditModal
	###
	describe "when ModalService.showAddEditModal()", ->
		beforeEach ->
			spyOn this.cacheService, "get"
			spyOn this.modalService, "showModal"
			return
		it "if valid, then show add/edit modal", ->
			this.modalService.showAddEditModal()
			expect this.cacheService.get
				.toHaveBeenCalledWith this.keys.app.dataTypeIdMap
			expect this.modalService.showModal
				.toHaveBeenCalled()
			return
		return
	return
