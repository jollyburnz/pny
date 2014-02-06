ngMeteor.controller "TodoCtrl", [
  "$scope"
  "$collection"
  ($scope, $collection) ->

    $collection "Todos", $scope

    $scope.addTodo = ->
      $scope.Todos.add
        text: $scope.todoText
        done: false

      $scope.todoText = ""
      return

    $scope.saveTodo = ->
      $scope.Todos.add $scope.Todos
      return

    $scope.remaining = ->
      count = 0
      angular.forEach $scope.Todos, (todo) ->
        count += (if todo.done then 0 else 1)
        return

      count
]
