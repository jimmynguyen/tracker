"use strict"

angular.module "app.services"

.factory "DatabaseService", (errors, firebaseConfig, firebaseErrorCodes, keys, overrideCacheService, CacheService, LoggingService, MappingService, UtilService, $firebaseArray, $q) ->

	# initialize firebase app if it has not been initialized
	if firebase.apps.length is 0
		firebase.initializeApp firebaseConfig
		# TODO: update to only run the below if running in production mode. otherwise, it will error out in the console. not a big deal, but it's probably bad practice
		firebase.auth().signInWithEmailAndPassword("jdoe@fakemail.com", "johndoe").catch (err) ->
			# handle errors
			LoggingService.error "firebase.auth().signInWithEmailAndPassword()", err
			return
		firebase.auth().onAuthStateChanged (user) ->
			if user
				# user is signed in
				# databaseService.account.get user.uid, (err, account) ->
				# 	if err
				# 		LoggingService.error "firebase.auth().onAuthStateChanged()", null, err
				# 	else
				# 		LoggingService.log account
				# 		CacheService.setUser account
				# 	return
				# return
				user =
					id: user.uid
				CacheService.setUser user
			else
				# user is signed out
			return

	# TODO: write tests
	databaseService =
		util:
			initialize: (scope) ->
				if CacheService.get(keys.app.dataTypeIdMap)?
					scope.isDatabaseInitialized = true
				else
					databaseService.dataType.getAllDefault (err, defaultDataTypes) ->
						if err
							LoggingService.error errors.DATABASE_SERVICE_INITIALIZATION, err
							scope.isDatabaseInitialized = false
						else
							CacheService.set keys.app.dataTypeIdMap, UtilService.data.getIdMap defaultDataTypes
							scope.isDatabaseInitialized = true
						return
				return
			getKey: (key, appendUserId, parentId, id) ->
				_key = angular.copy key
				if appendUserId
					_key += "/#{CacheService.getUser().id}"
				if parentId?
					_key += "/#{parentId}"
				if id?
					_key += "/#{id}"
				_key
			get: (key, appendUserId, parentId, overrideCacheService, definition, mapper, callback) ->
				key = databaseService.util.getKey key, appendUserId, parentId, null
				res = CacheService.get key
				if not res or overrideCacheService
					$firebaseArray firebase.database().ref().child key
						.$loaded()
						.then (res) ->
							mappedRes = mapper.map res, definition
							CacheService.set key, mappedRes
							callback null, mappedRes
						.catch UtilService.callback.database.catch "DatabaseService.util.get()", callback
				else
					callback null, res
			getUserObjects: (key, parentId, definition, mapper, callback) ->
				databaseService.util.get key, true, parentId, overrideCacheService, definition, mapper, callback
				return
			getSystemObjects: (key, parentId, definition, mapper, callback) ->
				databaseService.util.get key, false, parentId, overrideCacheService, definition, mapper, callback
				return
			setLastUpdatedField: (object) ->
				lastUpdated = new Date().getTime()
				object.last_updated = lastUpdated
				if object.fields?
					for field in object.fields
						field.last_updated = lastUpdated
				object
			add: (key, parentId, object, definition, mapper, callback) ->
				key = databaseService.util.getKey key, true, parentId, null
				object.id = firebase.database().ref().child(key).push().key
				object = mapper.reverseMap([object], definition)[0]
				object = databaseService.util.setLastUpdatedField object
				_key = databaseService.util.getKey key, false, null, object.id
				firebase.database().ref(_key).set object
					.then ->
						objects = CacheService.get key
						object = mapper.map([object], definition)[0]
						objects.push object
						CacheService.set key, objects
						callback null, objects
						return
					.catch UtilService.callback.database.catch "DatabaseService.util.add()", callback
				return
			update: (key, parentId, object, definition, mapper, callback) ->
				key = databaseService.util.getKey key, true, parentId, null
				object = mapper.reverseMap([object], definition)[0]
				object = databaseService.util.setLastUpdatedField object
				_key = databaseService.util.getKey key, false, null, object.id
				firebase.database().ref(_key).set object
					.then ->
						objects = CacheService.get key
						object = mapper.map([object], definition)[0]
						UtilService.object.copyProperties object, UtilService.data.getById objects, object.id
						CacheService.set key, objects
						callback null, objects
						return
					.catch UtilService.callback.database.catch "DatabaseService.util.update()", callback
				return
			delete: (key, parentId, object, callback) ->
				key = databaseService.util.getKey key, true, parentId, null
				if object?
					_key = databaseService.util.getKey key, false, null, object.id
				else
					_key = key
				firebase.database().ref(_key).remove()
					.then ->
						if object?
							objects = CacheService.get key
							UtilService.data.deleteById objects, object.id
							CacheService.set key, objects
							callback null, objects
						else
							CacheService.remove key
							callback null, null
						return
					.catch UtilService.callback.database.catch "DatabaseService.util.delete()", callback
				return
		# authentication:
		# 	login: (email, password) ->
		# 		firebase.auth().signInWithEmailAndPassword email, password
		# 			.then ->
		# 				user =
		# 					id: firebase.auth().currentUser.uid
		# 				CacheService.setUser user
		# 				databaseService.account.get (err, account) ->
		# 					if err
		# 						LoggingService.error "DatabaseService.util.login()", err
		# 						callback err, false
		# 					else
		# 						CacheService.setUser account
		# 						callback null, true
		# 					return
		# 			.catch (err) ->
		# 				LoggingService.error "DatabaseService.util.login()", err
		# 				callback err, false
		# 				return
		# 	logout: (callback) ->
		# 		firebase.auth().signOut()
		# 			.then ->
		# 				callback null
		# 				return
		# 			.catch (err) ->
		# 				LoggingService.error "DatabaseService.util.logout()", err
		# 				callback err
		# 				return
		# 		return
		# 	signUp: (email, password, callback) ->
		# 		firebase.auth().createUserWithEmailAndPassword email, password
		# 			.then (user) ->
		# 				# TODO: create user account
		# 				callback null, user
		# 				return
		# 			.catch (err) ->
		# 				LoggingService.error "DatabaseService.util.signUp()", err
		# 				callback err, null
		# 				return
		# 		return
		# account:
		# 	get: () ->
		# 		databaseService.util.get keys.user.accounts, true, null, true, MappingService.objectMapper
		category:
			getAll: (callback) ->
				databaseService.definition.getCategory UtilService.callback.default "DatabaseService.category.getAll()", callback, (err, res) ->
					databaseService.util.getUserObjects keys.user.categories, null, res, MappingService.arrayMapper, callback
					return
				return
			getById: (categoryId, callback) ->
				databaseService.category.getAll UtilService.callback.default "DatabaseService.category.getById()", callback, (err, res) ->
					res = UtilService.data.getById res, categoryId
					if not res
						err = errors.INVALID_CATEGORY_ID
					callback err, res
					return
				return
			add: (category, callback) ->
				databaseService.definition.getCategory UtilService.callback.default "DatabaseService.category.add()", callback, (err, res) ->
					databaseService.util.add keys.user.categories, null, category, res, MappingService.arrayMapper, callback
					return
				return
			update: (category, callback) ->
				databaseService.definition.getCategory UtilService.callback.default "DatabaseService.category.update()", callback, (err, res) ->
					databaseService.util.update keys.user.categories, null, category, res, MappingService.arrayMapper, callback
					return
				return
			delete: (category, callback) ->
				databaseService.util.delete keys.user.entries, category.id, null, UtilService.callback.default "DatabaseService.category.delete()", callback, (err, res) ->
					databaseService.util.delete keys.user.categories, null, category, callback
					return
				return
		dataType:
			getAllByUser: (callback) ->
				databaseService.util.getUserObjects keys.user.data_types, null, null, MappingService.arrayMapper, callback
				return
			getAllDefault: (callback) ->
				databaseService.util.getSystemObjects keys.system.default.data_types, null, null, MappingService.arrayMapper, callback
				return
		definition:
		# # 	getAccount: (callback) ->
		# # 		databaseService.util.getSystemObjects keys.system.definition.account, null, MappingService.arrayMapper, callback
		# # 		return
			getCategory: (callback) ->
				databaseService.definition.getField UtilService.callback.default "DatabaseService.definition.getCategory)", callback, (err, res) ->
					databaseService.util.getSystemObjects keys.system.definition.category, null, res, MappingService.arrayMapper, callback
					return
				return
		# # 	getDataType: (callback) ->
		# # 		databaseService.util.getSystemObjects keys.system.definition.data_type, null, MappingService.arrayMapper, callback
		# # 		return
			getDropdown: (callback) ->
				databaseService.definition.getField UtilService.callback.default "DatabaseService.definition.getDropdown)", callback, (err, res) ->
					databaseService.util.getSystemObjects keys.system.definition.dropdown, null, res, MappingService.arrayMapper, callback
					return
				return
			getField: (callback) ->
				databaseService.util.getSystemObjects keys.system.definition.field, null, null, MappingService.fieldMapper, callback
				return
		entry:
			getAll: (categoryId, definition, callback) ->
				databaseService.util.getUserObjects keys.user.entries, categoryId, definition, MappingService.arrayMapper, callback
				return
			add: (categoryId, entry, definition, callback) ->
				databaseService.util.add keys.user.entries, categoryId, entry, definition, MappingService.arrayMapper, callback
				return
			update: (categoryId, entry, definition, callback) ->
				databaseService.util.update keys.user.entries, categoryId, entry, definition, MappingService.arrayMapper, callback
				return
			delete: (categoryId, entry, callback) ->
				databaseService.util.delete keys.user.entries, categoryId, entry, callback
				return
		field:
			getAllDefault: (callback) ->
				databaseService.definition.getField UtilService.callback.default "DatabaseService.field.getAllDefault)", callback, (err, res) ->
					databaseService.util.getSystemObjects keys.system.default.fields, null, res, MappingService.arrayMapper, callback
					return
				return

	databaseService
