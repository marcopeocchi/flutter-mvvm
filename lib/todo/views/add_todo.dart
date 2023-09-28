import 'package:flutter/material.dart';
import 'package:mvvm_study/todo/store/todo.dart';
import 'package:provider/provider.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime selectedDate = RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> dateTimePickerRoute =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(selectedDate, 'selected_date');
    registerForRestoration(dateTimePickerRoute, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        selectedDate.value = newSelectedDate;
      });
    }
  }

  late TodoStore store;
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = Provider.of<TodoStore>(context);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a todo')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide a valid title';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a title',
                ),
                controller: controllerTitle,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide a valid description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a description',
                ),
                controller: controllerDescription,
              ),
              const SizedBox(height: 24.0),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  dateTimePickerRoute.present();
                },
                child: const Text('Select date'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            store.addTodo(
              title: controllerTitle.text,
              content: controllerDescription.text,
              dueDate: selectedDate.value,
            );
            Navigator.of(context).pop();
          }
        },
        tooltip: 'Add todo',
        child: const Icon(Icons.add_task),
      ),
    );
  }
}
