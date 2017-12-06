"use strict"

angular.module "app.services"

.factory "DatabaseService", (errors, firebaseConfig, firebaseErrorCodes, keys, CacheService, LoggingService, MappingService, UtilService, $firebaseArray, $q) ->

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
			initialize: (callback) ->
				if not CacheService.get keys.app.dataTypeIdMap
					databaseService.dataType.getAllDefault (err, defaultDataTypes) ->
						if err
							LoggingService.error "DatabaseService.util.initialize()", err
							callback err
						else
							dataTypeIdMap = {}
							defaultDataTypes.forEach (dataType) ->
								dataTypeIdMap[dataType.id] = dataType
							databaseService.dataType.getAllByUser (err, userDataTypes) ->
								if err
									LoggingService.error "DatabaseService.util.initialize()", err
									callback err
								else
									userDataTypes.forEach (dataType) ->
										dataTypeIdMap[dataType.id] = dataType
									CacheService.set keys.app.dataTypeIdMap, dataTypeIdMap
									callback null
								return
						return
				else
					callback null
				return
			getKey: (key, appendUserId, parentId, id) ->
				_key = key.slice 0
				if appendUserId
					_key += "/" + CacheService.getUser().id
				if parentId?
					_key += "/" + parentId
				if id?
					_key += "/" + id
				_key
			get: (key, appendUserId, parentId, overrideCacheService, definition, mapper, callback) ->
				# res = CacheService.get key
				# if not res or overrideCacheService
					_key = databaseService.util.getKey key, appendUserId, parentId, null
					$firebaseArray firebase.database().ref().child _key
						.$loaded()
						.then (res) ->
							mappedRes = mapper.map res, definition
							CacheService.set key, mappedRes
							callback null, mappedRes
						.catch (err) ->
							LoggingService.error "DatabaseService.util.get()", err
							callback err, null
				# else
				# 	callback null, res
			getUserObjects: (key, parentId, definition, mapper, callback) ->
				databaseService.util.get key, true, parentId, false, definition, mapper, callback
				return
			getSystemObjects: (key, parentId, definition, mapper, callback) ->
				databaseService.util.get key, false, parentId, false, definition, mapper, callback
				return
			setLastUpdatedField: (object) ->
				now = new Date()
				lastUpdated = UtilService.date.dateToString(now)
				object.last_updated = lastUpdated
				if object.fields?
					for field in object.fields
						field.last_updated = lastUpdated
				object
			add: (key, parentId, object, callback) ->
				_key = databaseService.util.getKey key, true, parentId, null
				object.id = firebase.database().ref().child(_key).push().key
				object = databaseService.util.setLastUpdatedField object
				_key = databaseService.util.getKey key, true, parentId, object.id
				firebase.database().ref(_key).set object
					.then ->
						objects = CacheService.get key
						objects.push object
						CacheService.set key, objects
						callback null, objects
						return
					.catch (err) ->
						LoggingService.error "DatabaseService.util.add()", err
						callback err, null
						return
				return
			update: (key, parentId, object, callback) ->
				object = databaseService.util.setLastUpdatedField object
				_key = databaseService.util.getKey key, true, parentId, object.id
				firebase.database().ref(_key).set object
					.then ->
						objects = CacheService.get key
						for o in objects
							if o.id is object.id
								for property of o
									o[property] = object[property]
								break
						CacheService.set key, objects
						callback null, objects
						return
					.catch (err) ->
						LoggingService.error "DatabaseService.util.update()", err
						callback err, null
						return
				return
			delete: (key, parentId, object, callback) ->
				_key = databaseService.util.getKey key, true, parentId, object.id
				firebase.database().ref(_key).remove()
					.then ->
						objects = CacheService.get key
						for o, i in objects
							if o.id is object.id
								objects.splice i, 1
								break
						CacheService.set key, objects
						callback null, objects
						return
					.catch (err) ->
						LoggingService.error "DatabaseService.delete()", err
						callback err, null
						return
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
				databaseService.definition.getCategory (err, definition) ->
					if err
						LoggingService.error "DatabaseService.category.getAll()", err
						callback err, null
					else
						databaseService.util.getUserObjects keys.user.categories, null, definition, MappingService.arrayMapper, callback
					return
				return
			getById: (categoryId, callback) ->
				databaseService.category.getAll (err, res) ->
					if err
						LoggingService.error "DatabaseService.category.getById()", err
						callback err, res
					else
						category = null
						for c in res
							if c.id is categoryId
								category = c
								break
						if not category
							err = errors.INVALID_CATEGORY_ID
							LoggingService.error "DatabaseService.category.getById()", err
							callback err, null
						else
							callback null, category
					return
				return
		# 	add: (category, callback) ->
		# 		databaseService.util.add keys.user.categories, null, category, callback
		# 		return
		# 	update: (category, callback) ->
		# 		databaseService.util.update keys.user.categories, null, category, callback
		# 		return
		# 	delete: (category, callback) ->
		# 		databaseService.util.delete keys.user.categories, null, category, callback
		# 		return
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
				databaseService.definition.getField (err, definition) ->
					if err
						LoggingService.error "DatabaseService.definition.getCategory()", err
						callback err, null
					else
						databaseService.util.getSystemObjects keys.system.definition.category, null, definition, MappingService.arrayMapper, callback
					return
				return
		# # 	getDataType: (callback) ->
		# # 		databaseService.util.getSystemObjects keys.system.definition.data_type, null, MappingService.arrayMapper, callback
		# # 		return
			getField: (callback) ->
				databaseService.util.getSystemObjects keys.system.definition.field, null, null, MappingService.fieldMapper, callback
				return
		entry:
			getAll: (categoryId, definition, callback) ->
				databaseService.util.getUserObjects keys.user.entries, categoryId, definition, MappingService.arrayMapper, callback
				return
		# 	add: (entry, categoryId, callback) ->
		# 		databaseService.util.add keys.user.entries, categoryId, entry, callback
		# 		return
		# 	update: (entry, categoryId, callback) ->
		# 		databaseService.util.update keys.user.entries, categoryId, entry, callback
		# 		return
		# 	delete: (entry, categoryId, callback) ->
		# 		databaseService.util.delete keys.user.entries, categoryId, entry, callback
		# 		return
		field:
			getAllDefault: (callback) ->
				databaseService.definition.getField (err, definition) ->
					if err
						LoggingService.error "DatabaseService.field.getAllDefault()", err
						callback err, null
					else
						databaseService.util.getSystemObjects keys.system.default.fields, null, definition, MappingService.arrayMapper, callback
					return
				return

	databaseService
