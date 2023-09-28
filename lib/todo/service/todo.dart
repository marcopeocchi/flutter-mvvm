import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/todo/entities/todo.dart';

abstract interface class TodoService {
  TaskEither<Failure, List<Todo>> all();
  TaskEither<Failure, Todo> add(Todo todo);
  TaskEither<Failure, Todo> search(String id);
  TaskEither<Failure, void> delete(String id);
  TaskEither<Failure, void> setCompleted(String id);
}
