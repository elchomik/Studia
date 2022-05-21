import 'package:another_flushbar/flushbar_helper.dart';
import 'package:firebase_flutter_ddd/application/notes/note_form/bloc/note_form_bloc.dart';
import 'package:firebase_flutter_ddd/domain/notes/value_objects.dart';
import 'package:firebase_flutter_ddd/presentation/pages/notes/note_form/misc/build_context_x.dart';
import 'package:firebase_flutter_ddd/presentation/pages/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kt_dart/collection.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.note.todos.isFull != current.note.todos.isFull,
      // ignore: unnecessary_parenthesis
      listener: ((context, state) {
        if (state.note.todos.isFull) {
          FlushbarHelper.createAction(
              message: 'Want a longer list? Buy premium',
              button: TextButton(
                onPressed: () {},
                child: const Text('BUY NOW'),
              )).show(context);
        }
      }),
      child: Consumer<FormTodos>(builder: (context, formTodos, child) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: formTodos.value.size,
            itemBuilder: (context, index) {
              return TodoTile(
                index: index,
                key: ValueKey(context.formTodos[index].id),
              );
            });
      }),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;

  const TodoTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());
    final textEditingController = useTextEditingController(text: todo.name);
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              context.formTodos = context.formTodos.minusElement(todo);
              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
            icon: Icons.delete,
            label: 'Delete',
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              context.formTodos = context.formTodos.map(
                (listTodo) => listTodo == todo
                    ? todo.copyWith(done: value ?? false)
                    : listTodo,
              );
              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
          ),
          title: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Todo',
              border: InputBorder.none,
              counterText: '',
            ),
            maxLength: TodoName.maxLength,
            controller: textEditingController,
            onChanged: (value) {
              context.formTodos = context.formTodos.map((listTodo) =>
                  listTodo == todo ? todo.copyWith(name: value) : listTodo);
              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
            validator: (_) {
              return context.read<NoteFormBloc>().state.note.todos.value.fold(
                  (f) => null,
                  (todoList) => todoList[index].name.value.fold(
                        (f) => f.maybeMap(
                          empty: (_) => 'Can not be empty',
                          exceddingLength: (_) => ' Too long',
                          multiline: (_) => 'Has to be in a single line',
                          orElse: () => null,
                        ),
                        (_) => null,
                      ));
            },
          ),
        ),
      ),
    );
  }
}
