import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/todo/entities/todo.dart';
import 'package:mvvm_study/todo/repository/todo.dart';
import 'package:mvvm_study/todo/service/todo.dart';

class TodoServiceImpl implements TodoService {
  final TodoRepository repository;

  TodoServiceImpl(this.repository);

  @override
  TaskEither<Failure, List<Todo>> all() {
    return repository.all();
  }

  @override
  TaskEither<Failure, Todo> add(Todo todo) {
    return repository.add(todo);
  }

  @override
  TaskEither<Failure, void> delete(String id) {
    return repository.delete(id);
  }

  @override
  TaskEither<Failure, Todo> search(String id) {
    return repository.search(id);
  }

  @override
  TaskEither<Failure, void> setCompleted(String id) {
    return repository.setCompleted(id);
  }
}
