import 'package:flutter/material.dart';
import 'package:todoist_test/model/todo.dart';
import 'package:todoist_test/ui/create_edit_todo_screen.dart';
import 'package:todoist_test/ui/widgets.dart';

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
            itemBuilder: (context, index) => TodoItem(
              todo: widget.screenData.todosList[index],
            ),
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

  Future<void> openCreateEditTodoScreen() async {
    final createEditTodoScreenData = CreateEditTodoScreenData();

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

    print('RESULT IS: $result');

    if (result != null) {
      setState(() {
        widget.screenData.todosList.add(result);
      });
    }
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
