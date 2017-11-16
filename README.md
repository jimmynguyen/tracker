# tracker

## Architecture

### Database & API

Firebase will be used to for all database and API functionalities.

Link to Firebase project: [https://tracker-9c7c9.firebaseio.com/](https://tracker-9c7c9.firebaseio.com/
)

#### Database Structure

##### object

Table of objects with fields:

| field        | required | description |
| ------------ | -------- | ----------- |
| id           | required | unique id                                        |
| parent_id    | optional | unique id of parent element                      |
| name         | required | object descriptor                                |
| description  | optional | detailed description of the object               |
| start_date   | optional | start date                                       |
| end_date     | optional | end date                                         |
| children     | optional | list of objects that are children of this object |
| data_type    | required | data type (text, number, etc)                    |
| last_updated | required | timestamp of when the object was last updated    |
