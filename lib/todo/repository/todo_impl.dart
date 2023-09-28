import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:mvvm_study/core/failures.dart';
import 'package:mvvm_study/todo/models/todo_model.dart';
import 'package:mvvm_study/todo/repository/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoRepositoryImpl implements TodoRepository {
  final SharedPreferences preferences;

  TodoRepositoryImpl(this.preferences);

  @override
  TaskEither<Failure, List<TodoModel>> all() {
    // Retrieve all todos
    TaskEither<Failure, List<TodoModel>> listAllTodos(List<String> list) =>
        TaskEither.tryCatch(
          () async {
            return list.map((e) => TodoModel.fromJson(jsonDecode(e))).toList();
          },
          (error, stackTrace) => LocalStorageFailure(
            error: error,
            stacktrace: stackTrace,
          ),
        );

    // Get the underling storage list
    TaskEither<Failure, List<String>> getSharedPreferencesList() =>
        TaskEither.tryCatch(
          () async => preferences.getStringList("todos") ?? List.empty(),
          (_, __) => const LocalStorageFailure(),
        );

    return getSharedPreferencesList().flatMap((r) => listAllTodos(r));
  }

  @override
  TaskEither<Failure, TodoModel> add(TodoModel todo) {
    return TaskEither.tryCatch(
      () async {
        var list = preferences.getStringList("todos");
        list ??= List.empty(growable: true);

        list.add(jsonEncode(todo.toJson()));
        preferences.setStringList("todos", list);
        return todo;
      },
      (error, stackTrace) => LocalStorageFailure(
        error: error,
        stacktrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<Failure, void> delete(String id) {
    return TaskEither.tryCatch(
      () async {
        var list = preferences.getStringList("todos");
        list ??= List.empty();

        list.removeWhere((element) {
          return TodoModel.fromJson(jsonDecode(element)).id == id;
        });

        preferences.setStringList("todos", list);
      },
      (error, stackTrace) => LocalStorageFailure(
        error: error,
        stacktrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<Failure, TodoModel> search(String id) {
    return TaskEither.tryCatch(
      () async {
        final encoded = preferences.getString(id);
        if (encoded == null) {
          throw "not found";
        }
        final decoded = jsonDecode(encoded);
        return TodoModel.fromJson(decoded);
      },
      (error, stackTrace) => LocalStorageFailure(
        error: error,
        stacktrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<Failure, void> setCompleted(String id) {
    return TaskEither.tryCatch(
      () async {
        var list = preferences.getStringList("todos");
        list ??= List.empty();

        final edited = list.map((element) {
          final todo = TodoModel.fromJson(jsonDecode(element));
          if (todo.id == id) {
            return jsonEncode(TodoModel(
              id: id,
              title: todo.title,
              content: todo.content,
              dueDate: todo.dueDate,
              completed: true,
            ).toJson());
          }
          return element;
        }).toList();

        preferences.setStringList("todos", edited);
      },
      (error, stackTrace) => LocalStorageFailure(
        error: error,
        stacktrace: stackTrace,
      ),
    );
  }
}
