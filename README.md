## How to run API server
Clone the repository
```
$ git clone git@github.com:ryanicle/fm.git
```

Install necessary gems, install database and run rails server locally
```
$ bundle install && bundle exec rake db:migrate && rails server
```

Locate http://localhost:8000/ in the browser and it should be running.


### Requirements
- Ruby 2.5.1
- Rails 5.2

### Documentation
This API server is developed using Ruby as programming language and Rails as framework to help speed up the rapid development.

There are a total of six API endpoints. They are
```
POST /api/v1/friends/add
GET  /api/v1/friends/list
GET  /api/v1/friends/common
POST /api/v1/friends/subscribe
PUT  /api/v1/friends/unsubscribe
GET  /api/v1/friends/updates
```
```POST``` method is being used for creating a new record, in this case, it was used to request friend and subscribe to updates.

```PUT``` method is being used for updating an existing record

```GET``` method is being used for retrieving records

There is a namespace ```/api/v1/``` which is clearly defined to keep API in versions. In future, it could easily make space for new version. For e.g., it could be developed as ```/api/v2/``` for API version 2. This will keep things organized and be easier to manage and maintain.


### How to run test cases

```
$ rails test
```

