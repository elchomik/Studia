import 'package:firebase_flutter_ddd/domain/core/value_objects.dart';
import 'package:firebase_flutter_ddd/domain/notes/todo_item.dart';
import 'package:firebase_flutter_ddd/domain/notes/value_objects.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'todo_item_presentation_classes.freezed.dart';

class FormTodos extends ValueNotifier<KtList<TodoItemPrimitive>> {
  FormTodos() : super(emptyList<TodoItemPrimitive>());
}

@freezed
abstract class TodoItemPrimitive with _$TodoItemPrimitive {
  const factory TodoItemPrimitive(
      {required UniqueId id,
      required String name,
      required bool done}) = _TodoItemPrimitive;

  factory TodoItemPrimitive.empty() =>
      TodoItemPrimitive(id: UniqueId(), name: '', done: false);

  factory TodoItemPrimitive.fromDomain(TodoItem todoItem) {
    return TodoItemPrimitive(
        id: todoItem.id, name: todoItem.name.getOrCrash(), done: todoItem.done);
  }

  TodoItem toDomain() => TodoItem(id: id, name: TodoName(name), done: done);

  const TodoItemPrimitive._();
}
