import 'package:flutter/material.dart';
import 'package:todo_flutter/model/todo.dart';

class TodoForm extends StatefulWidget {
  int? id;
  String? todo;
  String? content;

  TodoForm({Key? key, this.id, this.todo, this.content}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  TextEditingController todoController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      todoController.text = widget.todo!;
      contentController.text = widget.content!;
    } else {
      todoController.text = '(Untitled) Todo';
      contentController.text = 'Content';
    }
  }

  Future<bool> onWillPop() async {
    if (todoController.text.isEmpty && contentController.text.isEmpty) {
      Navigator.pop(
          context,
          Todo(
              id: null,
              todo: '(Untitled) Todo',
              description: 'Content',
              isComplete: false));
      return true;
    } else {
      Navigator.pop(
          context,
          Todo(
              id: widget.id,
              todo: todoController.text,
              description: contentController.text,
              isComplete: false));
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: IconButton(
                        onPressed: onWillPop,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                        )),
                  ),
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: TextField(
                      style: const TextStyle(fontSize: 18),
                      controller: todoController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 100)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
