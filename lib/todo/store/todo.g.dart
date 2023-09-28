// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoStore on _TodoStoreBase, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: '_TodoStoreBase.state'))
      .value;

  late final _$todosAtom = Atom(name: '_TodoStoreBase.todos', context: context);

  @override
  List<Todo>? get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(List<Todo>? value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  late final _$errorAtom = Atom(name: '_TodoStoreBase.error', context: context);

  @override
  Failure? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Failure? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$getAllAsyncAction =
      AsyncAction('_TodoStoreBase.getAll', context: context);

  @override
  Future<void> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  late final _$addTodoAsyncAction =
      AsyncAction('_TodoStoreBase.addTodo', context: context);

  @override
  Future<void> addTodo(
      {required String title,
      required String content,
      required DateTime dueDate}) {
    return _$addTodoAsyncAction.run(
        () => super.addTodo(title: title, content: content, dueDate: dueDate));
  }

  late final _$removeTodoAsyncAction =
      AsyncAction('_TodoStoreBase.removeTodo', context: context);

  @override
  Future<void> removeTodo(String id) {
    return _$removeTodoAsyncAction.run(() => super.removeTodo(id));
  }

  late final _$setCompletedAsyncAction =
      AsyncAction('_TodoStoreBase.setCompleted', context: context);

  @override
  Future<void> setCompleted(String id) {
    return _$setCompletedAsyncAction.run(() => super.setCompleted(id));
  }

  @override
  String toString() {
    return '''
todos: ${todos},
error: ${error},
state: ${state}
    ''';
  }
}
