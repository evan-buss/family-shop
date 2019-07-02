import 'state.dart';

// One simple action: Increment
enum Actions { Increment }

class AddTodoAction {
  final Todo todo;

  AddTodoAction(this.todo);
}

class UpdateNameAction {
  final String name;

  UpdateNameAction(this.name);
}