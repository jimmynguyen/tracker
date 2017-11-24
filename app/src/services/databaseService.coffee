"use strict"

angular.module "app.services"

.factory "DatabaseService", (firebaseConfig, firebaseErrorCodes, keys, CookieService, LoggingService, MappingService, $firebaseArray, $q) ->

	# initialize firebase app if it has not been initialized
	if firebase.apps.length is 0
		firebase.initializeApp firebaseConfig
		# TODO: update to only run the below if running in production mode. otherwise, it will error out in the console. not a big deal, but it's probably bad practice
		# firebase.auth().signInAnonymously().catch (err) ->
		# 	# handle errors
		# 	LoggingService.error "databaseService", null, err
		# 	return
		# firebase.auth().onAuthStateChanged (user) ->
		# 	LoggingService.log "onAuthStateChanged:"
		# 	LoggingService.log user
		# 	if user
		# 		# user is signed in
		# 		databaseService.account.get user.uid, (err, account) ->
		# 			if err
		# 				LoggingService.error "firebase.auth().onAuthStateChanged()", null, err
		# 			else
		# 				LoggingService.log account
		# 				CookieService.setUser account
		# 			return
		# 		return
		# 	else
		# 		# user is signed out
		# 	return

	# TODO: write tests
	databaseService =
		util:
			getKey: (key, appendUserId, parentId, id) ->
				_key = key.slice 0
				if appendUserId
					_key += "/" + CookieService.getUser().id
				if parentId?
					_key += "/" + parentId
				if id?
					_key += "/" + id
				_key
			getUpdate: (key, object) ->
				update = []
				update[key] = object
				update
			# get: (key, appendUserId, parentId, overrideCookieService, mapper) ->
			# 	res = CookieService.get key
			# 	if not res or overrideCookieService
			# 		_key = databaseService.util.getKey key, appendUserId, parentId, null
			# 		firebasePromise = $firebaseArray firebase.database().ref().child _key
			# 			.$loaded()
			# 			.then (res) ->
			# 				mappedRes = mapper.map res
			# 				CookieService.set key, mappedRes
			# 				return mappedRes
			# 			.catch (err) ->
			# 				LoggingService.error "databaseService.util.get()", key, err
			# 				throw err
			# 		promise = $q.when firebasePromise
			# 	else
			# 		promise = $q.when res
			# 	promise
		# 	login: (email, password) ->
		# 		firebase.auth().signInWithEmailAndPassword email, password
		# 			.then ->
		# 				user =
		# 					id: firebase.auth().currentUser.uid
		# 				CookieService.setUser user
		# 				databaseService.account.get (err, account) ->
		# 					if err
		# 						LoggingService.error "databaseService.util.login()", null, err
		# 						callback err, false
		# 					else
		# 						CookieService.setUser account
		# 						callback null, true
		# 					return
		# 			.catch (err) ->
		# 				LoggingService.error "databaseService.util.login()", null, err
		# 				callback err, false
		# 				return
		# 	logout: (callback) ->
		# 		firebase.auth().signOut()
		# 			.then ->
		# 				callback null
		# 				return
		# 			.catch (err) ->
		# 				LoggingService.error "databaseService.util.logout()", null, err
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
		# 				LoggingService.error "databaseService.signUp()", null, err
		# 				callback err, null
		# 				return
		# 		return
		# 	getUserObjects: (key, parentId, mapper, callback) ->
		# 		databaseService.util.get key, true, parentId, false, mapper, callback
		# 		return
		# 	getSystemObjects: (key, parentId, mapper, callback) ->
		# 		databaseService.util.get key, false, parentId, false, mapper, callback
		# 		return
		# 	add: (key, appendUserId, parentId, object, callback) ->
		# 		_key = databaseService.util.getKey key, appendUserId, parentId, null
		# 		object.id = firebase.database().ref().child _key
		# 			.push().key
		# 		_key = databaseService.util.getKey key, appendUserId, parentId, object.id
		# 		update = databaseService.util.getUpdate _key, object
		# 		firebase.database().ref().update update
		# 			.then ->
		# 				callback null, object.id
		# 				return
		# 			.catch (err) ->
		# 				callback err, null
		# 				return
		# 		return
		# 	update: (key, appendUserId, parentId, object, callback) ->
		# 		_key = databaseService.util.getKey key, appendUserId, parentId, object.id
		# 		update = databaseService.util.getUpdate _key, object
		# 		firebase.database().ref().update update
		# 			.then ->
		# 				callback null
		# 				return
		# 			.catch (err) ->
		# 				callback err
		# 				return
		# 		return
		# 	delete: (key, appendUserId, parentId, object, callback) ->
		# 		_key = databaseService.util.getKey key, appendUserId, parentId, object.id
		# 		firebase.database().ref().child _key
		# 			.remove()
		# 			.then ->
		# 				callback null
		# 				return
		# 			.catch (err) ->
		# 				callback err
		# 				return
		# 		return
		# account:
		# 	get: () ->
		# 		databaseService.util.get keys.user.accounts, true, null, true, MappingService.account
		# category:
		# 	getAll: (callback) ->
		# 		databaseService.util.getUserObjects keys.user.categories, null, MappingService.default, callback
		# 		return
		# field:
		# 	getAllDefault: (callback) ->
		# 		databaseService.util.getSystemObjects keys.system.default.fields, null, MappingService.default, callback
		# 		return
		# dataType:
		# 	getAllByUser: (callback) ->
		# 		databaseService.util.getUserObjects keys.user.data_types, null, MappingService.default, callback
		# 		return
		# 	getAllDefault: (callback) ->
		# 		databaseService.util.getSystemObjects keys.system.default.data_types, null, MappingService.default, callback
		# 		return
		# definition:
		# 	getAccount: (callback) ->
		# 		databaseService.util.getSystemObjects keys.system.definition.user, null, MappingService.default, callback
		# 		return
		# 	getCategory: (callback) ->
		# 		databaseService.util.getSystemObjects keys.system.definition.category, null, MappingService.default, callback
		# 		return
		# 	getDataType: (callback) ->
		# 		databaseService.util.getSystemObjects keys.system.definition.data_type, null, MappingService.default, callback
		# 		return
		# 	getField: (callback) ->
		# 		databaseService.util.getSystemObjects keys.system.definition.field, null, MappingService.default, callback
		# 		return
		# entry:
		# 	getAll: (categoryId, callback) ->
		# 		databaseService.util.getUserObjects keys.user.entries, categoryId, MappingService.default, callback
		# 		return

	databaseService
