"use strict"

angular.module "app.config"

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
