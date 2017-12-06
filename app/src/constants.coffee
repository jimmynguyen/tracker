"use strict"

angular.module "app.constants"

.constant "firebaseConfig",
	apiKey: "AIzaSyC84FRJ5B4fs1ZqHwFjv7uhQ3rr3NaFJ-c"
	authDomain: "tracker-9c7c9.firebaseapp.com"
	databaseURL: "https://tracker-9c7c9.firebaseio.com"
	projectId: "tracker-9c7c9"
	storageBucket: "tracker-9c7c9.appspot.com"
	messagingSenderId: "542245163827"

.constant "firebaseTestConfig",
	apiKey: "fake-api-key-for-testing-purposes-only"
	databaseURL: "ws://test.firebaseio.localhost:5000"

.constant "keys",
	system:
		default:
			data_types: "system/default/data_types"
			fields: "system/default/fields"
		definition:
			account: "system/definition/account"
			category: "system/definition/category"
			data_type: "system/definition/data_type"
			field: "system/definition/field"
	user:
		accounts: "user/accounts"
		categories: "user/categories"
		data_types: "user/data_types"
		entries: "user/entries"
	selected:
		category: "selected/category"
		entry: "selected/entry"
	app:
		dataTypeIdMap: "app/dataTypeIdMap"

.constant "errors",
	INVALID_EMAIL_OR_PASSWORD: "Invalid email or password"
	INVALID_CATEGORY_ID: "Invalid category id"
	DATABASE_INITIALIZATION: "Error during DatabaseService initialization"

.constant "firebaseErrorCodes",
	auth:
		EMAIL_ALREADY_IN_USE: "auth/email-already-in-use"
		INVALID_EMAIL: "auth/invalid-email"
		OPERATION_NOT_ALLOWED: "auth/operation-not-allowed"
		WEAK_PASSWORD: "auth/weak-password"
