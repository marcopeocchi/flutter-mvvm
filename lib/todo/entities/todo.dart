import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime dueDate;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.content,
    required this.dueDate,
    required this.completed,
  });

  @override
  List<Object> get props => [title, content, completed, dueDate];

  bool get isEmpty => title.isEmpty && content.isEmpty;
  bool get isNotEmpty => title.isNotEmpty && content.isNotEmpty;
}
