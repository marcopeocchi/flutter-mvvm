import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm_study/todo/entities/todo.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.title,
    required super.content,
    required super.dueDate,
    required super.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
