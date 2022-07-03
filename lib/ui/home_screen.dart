import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:todoist_test/model/todo.dart';
import 'package:todoist_test/ui/create_edit_todo_screen.dart';
import 'package:todoist_test/ui/widgets.dart';
import 'package:collection/collection.dart';

class HomeScreen extends StatefulWidget {
  final ScreenData screenData;

  const HomeScreen({
    Key? key,
    required this.screenData,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenData.title),
      ),
      body: Column(
        children: [
          if (widget.screenData.todosList.isEmpty) ...[
            const Expanded(
              child: Center(
                child: Text(
                  'Press plus to add a todo!',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            )
          ],
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = widget.screenData.todosList[index];

              return SwipeActionCell(
                key: ObjectKey(item),
                fullSwipeFactor: 0.6,
                trailingActions: <SwipeAction>[
                  SwipeAction(
                    performsFirstActionWithFullSwipe: true,
                    onTap: (CompletionHandler handler) async {
                      await handler(true);
                      setState(() {
                        widget.screenData.todosList.remove(item);
                      });
                    },
                    color: Colors.transparent,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    widthSpace: 60,
                  ),
                  SwipeAction(
                    performsFirstActionWithFullSwipe: true,
                    onTap: (CompletionHandler handler) async {
                      handler(false);
                      openCreateEditTodoScreen(todoToEdit: item);
                    },
                    color: Colors.transparent,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    widthSpace: 60,
                  ),
                ],
                child: TodoItem(
                  todo: item,
                ),
              );
            },
            itemCount: widget.screenData.todosList.length,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openCreateEditTodoScreen();
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> openCreateEditTodoScreen({Todo? todoToEdit}) async {
    final createEditTodoScreenData =
        CreateEditTodoScreenData(todoToEdit: todoToEdit);

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CreateEditTodoScreen(screenData: createEditTodoScreenData),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (_isNewTodo(result.id, widget.screenData.todosList)) {
          widget.screenData.todosList.add(result);
        } else {
          widget.screenData.todosList[widget.screenData.todosList
              .indexWhere((element) => element.id == result.id)] = result;
        }
      });
    }
  }

  bool _isNewTodo(int todoId, List<Todo> todosList) {
    Todo? oldTodo;

    oldTodo = todosList.firstWhereOrNull((element) => element.id == todoId);

    return oldTodo == null;
  }
}

class ScreenData {
  final String title;
  List<Todo> todosList = [
    // Todo(
    //   name: 'TODO 1',
    //   priority: Priority.normal,
    //   date: DateTime.now(),
    //   tag: 'tag',
    //   description: 'TODO 1 description',
    // ),
    // Todo(
    //   name: 'TODO 2',
    //   priority: Priority.normal,
    //   date: DateTime.now(),
    //   tag: 'tag',
    //   description: 'TODO 2 description',
    // ),
  ];

  ScreenData({required this.title});
}
