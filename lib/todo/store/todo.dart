import 'package:mobx/mobx.dart';
import 'package:mvvm_study/todo/entities/todo.dart';
import 'package:mvvm_study/todo/service/todo.dart';
import 'package:mvvm_study/core/failure.dart';
import 'package:nanoid/non_secure.dart';

part 'todo.g.dart';

enum StoreState { initial, loading, loaded }

class TodoStore extends _TodoStoreBase with _$TodoStore {
  TodoStore(super.service);
}

abstract class _TodoStoreBase with Store {
  final TodoService _service;

  _TodoStoreBase(this._service);

  @observable
  List<Todo>? todos;

  @observable
  Failure? error;

  @computed
  StoreState get state {
    if (todos == null) {
      return StoreState.loading;
    }
    if (todos != null && todos!.isEmpty) {
      return StoreState.initial;
    }
    if (todos!.isNotEmpty) {
      return StoreState.loaded;
    }
    return StoreState.initial;
  }

  void resetState() {
    todos = null;
  }

  @action
  Future<void> getAll() async {
    resetState();
    final task = await _service.all().run();
    task.match(
      (l) => error = l,
      (r) => todos = r,
    );
  }

  @action
  Future<void> addTodo({
    required String title,
    required String content,
    required DateTime dueDate,
  }) async {
    final task = await _service
        .add(Todo(
          id: nanoid(),
          title: title,
          content: content,
          dueDate: dueDate,
          completed: false,
        ))
        .run();

    task.match((l) => error = l, (r) => getAll());
  }

  @action
  Future<void> removeTodo(String id) async {
    final task = await _service.delete(id).run();

    task.match((l) => error = l, (r) => getAll());
  }

  @action
  Future<void> setCompleted(String id) async {
    final task = await _service.setCompleted(id).run();

    task.match((l) => error = l, (r) => getAll());
  }
}
