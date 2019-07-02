import 'package:family_list/redux/actions.dart';
import 'package:family_list/redux/state.dart';

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }

  return state;
}

AppState todosReducer(AppState state, action) {
  // Check to see if the dispatched Action is an AddTodoAction
  if (action is AddTodoAction) {
    // If it is, add the todo to our list!
    return new AppState(
      // We don't mutate the previous list! We copy it and THEN add the new todo.
      todos: new List.from(state.todos)..add(action.todo),
      // Don't modify the value of visibilityFilter, just use the previous value
    );
  } else if (action is UpdateNameAction) {
    return AppState(todos: state.todos, name: action.name);
  } else {
    return state;
  }
}
