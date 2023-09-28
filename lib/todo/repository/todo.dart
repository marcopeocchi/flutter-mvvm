import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/todo/models/todo_model.dart';

abstract interface class TodoRepository {
  TaskEither<Failure, List<TodoModel>> all();
  TaskEither<Failure, TodoModel> add(TodoModel todo);
  TaskEither<Failure, TodoModel> search(String id);
  TaskEither<Failure, void> delete(String id);
  TaskEither<Failure, void> setCompleted(String id);
}
