// User Class contains user information
//class User {
//  String name, email, password;
//  User(this.name, this.email, this.password);
//}

class Todo {
  String task;
  bool completed;

  Todo(this.task, {this.completed = false});
}

// Define an AppState class that contains a List of Todos and the VisibilityFilter.
class AppState {
  List<Todo> todos;
  String name;

  // The AppState constructor can contain default values. No need to define these in another
  // place, like the Reducer.
  AppState({
    this.todos = const [],
    this.name = "Evan Buss"
  });
}