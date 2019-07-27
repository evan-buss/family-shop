// User Class contains user information
class User {
  String name, email, password;
  User(this.name, this.email, this.password);
}

// Define an AppState class that contains a List of Todos and the VisibilityFilter.
class AppState {
  bool loggedIn;
  User user;

  // The AppState constructor can contain default values. No need to define these in another
  // place, like the Reducer.
AppState({
  this.user,
  this.loggedIn = false});
}
