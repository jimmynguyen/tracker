var FirebaseServer = require('firebase-server');

new FirebaseServer(5000, 'test.firebaseio.localhost', {
    {
      "category" : [ {
        "field" : [ {
          "data_type" : "string",
          "name" : "title",
          "order" : 1
        }, {
          "data_type" : "movie_genre",
          "name" : "genre",
          "order" : 2
        }, {
          "data_type" : "movie_status",
          "name" : "status",
          "order" : 3
        }, {
          "data_type" : "string",
          "name" : "comments",
          "order" : 4
        } ],
        "id" : 0,
        "name" : "movies",
        "user_id" : 0
      } ],
      "movies" : {
        "user_id" : 0,
        "value" : [ {
          "comments" : "dank movie",
          "genre" : "action",
          "id" : 0,
          "last_updated" : "11/16/2017 16:12",
          "status" : "watched",
          "title" : "The Avengers"
        } ]
      },
      "system_definition" : {
        "category" : {
          "field" : [ {
            "data_type" : "string",
            "name" : "name"
          }, {
            "data_type" : "field",
            "name" : "field"
          }, {
            "data_type" : "number",
            "name" : "user_id"
          } ]
        },
        "data_type" : [ "array", "datetime", "field", "number", "string" ],
        "default_field" : [ {
          "data_type" : "number",
          "name" : "id"
        }, {
          "data_type" : "datetime",
          "name" : "last_updated"
        } ],
        "field" : [ {
          "data_type" : "string",
          "name" : "data_type"
        }, {
          "data_type" : "string",
          "name" : "name"
        }, {
          "data_type" : "number",
          "name" : "id"
        } ],
        "user" : {
          "field" : [ {
            "data_type" : "string",
            "name" : "name"
          } ]
        }
      },
      "user" : [ {
        "data_type_id" : [ 0, 1 ],
        "email" : "jdoe@fakemail.com",
        "id" : 0,
        "name" : "John Doe",
        "password" : "password",
        "username" : "jdoe"
      } ],
      "user_definition" : {
        "data_type" : [ {
          "name" : "movie_genre",
          "user_id" : 0,
          "value" : [ "action", "horror", "mystery" ]
        }, {
          "name" : "movie_status",
          "user_id" : 0,
          "value" : [ "watched", "plan on watching" ]
        } ]
      }
    }
});
