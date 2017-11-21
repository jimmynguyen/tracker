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
	default:
		dataTypes: "system_definition/data_type"
		fields: "system_definition/default_field"
	definition:
		user:
			dataTypes: "user_definition/data_type"
		system:
			category: "system_definition/category"
			field: "system_definition/field"
			user: "system_definition/user"
	categories: "category"
	users: "user"

.constant "errors",
	INVALID_EMAIL_OR_PASSWORD: "Invalid email or password"

.constant "firebaseErrorCodes",
	auth:
		EMAIL_ALREADY_IN_USE: "auth/email-already-in-use"
		INVALID_EMAIL: "auth/invalid-email"
		OPERATION_NOT_ALLOWED: "auth/operation-not-allowed"
		WEAK_PASSWORD: "auth/weak-password"
