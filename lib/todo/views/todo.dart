import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mvvm_study/core/widgets/failure.dart';
import 'package:mvvm_study/todo/store/todo.dart';
import 'package:mvvm_study/todo/views/add_todo.dart';
import 'package:provider/provider.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  late TodoStore store;
  late List<ReactionDisposer> disposers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = Provider.of<TodoStore>(context);
    store.getAll();
    disposers = [];
  }

  @override
  void dispose() {
    disposers.map((disposer) => disposer());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => store.getAll(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Observer(
            builder: (context) {
              if (store.error != null) {
                return FailureWidget(failure: store.error!);
              }
              if (store.state == StoreState.initial) {
                return const Center(child: Text('Mmmhh, empty...'));
              }
              if (store.state == StoreState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: store.todos!.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(store.todos![index].title),
                    subtitle: Text(store.todos![index].content),
                    trailing: IconButton(
                      icon: store.todos![index].completed
                          ? const Icon(Icons.delete_outlined)
                          : const Icon(Icons.task_alt),
                      onPressed: store.todos![index].completed
                          ? () => store.removeTodo(store.todos![index].id)
                          : () => store.setCompleted(store.todos![index].id),
                    ),
                  ));
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const AddTodoView();
          },
        )),
        tooltip: 'Add todo',
        child: const Icon(Icons.add_task),
      ),
    );
  }
}
