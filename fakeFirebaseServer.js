var FirebaseServer = require('firebase-server');

new FirebaseServer(5000, 'test.firebaseio.localhost',{
	"system": {
		"default": {
			"data_types": [
				"array",
				"datetime",
				"field",
				"number",
				"string"
			],
			"fields": [
				{
					"data_type": "number",
					"name": "id"
				},
				{
					"data_type": "datetime",
					"name": "last_updated"
				}
			]
		},
		"definition": {
			"category": [
				{
					"data_type": "field",
					"name": "field"
				},
				{
					"data_type": "number",
					"name": "id"
				},
				{
					"data_type": "string",
					"name": "last_updated"
				},
				{
					"data_type": "string",
					"name": "name"
				}
			],
			"data_type": [
				{
					"data_type": "array",
					"name": "value"
				},
				{
					"data_type": "number",
					"name": "id"
				},
				{
					"data_type": "string",
					"name": "last_updated"
				},
				{
					"data_type": "string",
					"name": "name"
				}
			],
			"field": [
				{
					"data_type": "string",
					"name": "data_type"
				},
				{
					"data_type": "number",
					"name": "id"
				},
				{
					"data_type": "string",
					"name": "last_updated"
				},
				{
					"data_type": "string",
					"name": "name"
				},
				{
					"data_type": "number",
					"name": "order"
				}
			],
			"user": [
				{
					"data_type": "string",
					"name": "email"
				},
				{
					"data_type": "string",
					"name": "first_name"
				},
				{
					"data_type": "string",
					"name": "last_name"
				},
				{
					"data_type": "string",
					"name": "last_updated"
				}
			]
		}
	},
	"user": {
		"categories": {
			"IY2ZMGNzsTPmWdmi3lec35v2CRt2": [
				{
					"fields": [
						{
							"data_type": "string",
							"id": 0,
							"last_updated": "11/20/2017 14:41:24",
							"name": "title",
							"order": 1
						},
						{
							"data_type": "movie_genre",
							"id": 1,
							"last_updated": "11/20/2017 14:41:24",
							"name": "genre",
							"order": 2
						},
						{
							"data_type": "movie_status",
							"id": 2,
							"last_updated": "11/20/2017 14:41:24",
							"name": "status",
							"order": 3
						},
						{
							"data_type": "string",
							"id": 3,
							"last_updated": "11/20/2017 14:41:24",
							"name": "comments",
							"order": 4
						}
					],
					"id": 0,
					"last_updated": "11/20/2017 14:39:24",
					"name": "movies"
				}
			]
		},
		"data_types": {
			"IY2ZMGNzsTPmWdmi3lec35v2CRt2": [
				{
					"id": 0,
					"last_updated": "11/20/2017 14:45:30",
					"name": "movie_genre",
					"value": [
						"action",
						"horror",
						"mystery"
					]
				},
				{
					"id": 1,
					"last_updated": "11/20/2017 14:45:30",
					"name": "movie_status",
					"value": [
						"watched",
						"plan on watching"
					]
				}
			]
		},
		"entries": {
			"IY2ZMGNzsTPmWdmi3lec35v2CRt2": {
				"0": [
					{
						"comments": "dank movie",
						"genre": "action",
						"id": 0,
						"last_updated": "11/16/2017 16:12",
						"status": "watched",
						"title": "The Avengers"
					}
				]
			}
		},
		"accounts": {
			"IY2ZMGNzsTPmWdmi3lec35v2CRt2": {
				"email": "jdoe@fakemail.com",
				"first_name": "John",
				"id": "IY2ZMGNzsTPmWdmi3lec35v2CRt2",
				"last_name": "Doe",
				"last_updated": "11/20/2017 14:38:09"
			}
		}
	}
});
