angular.module("sessions", []).factory("Session", ['$http', ($http) ->

  Session = {}

  Session.index = (callback) ->
      $http.get("/api/v1/sessions.json").success( (data) ->
        callback(data)
      ).error( ->
        console.error('Failed to load sessions.')
        callback([])
      )

  Session.live = (id, callback) ->


  return Session

])