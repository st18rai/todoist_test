import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';

import '../model/todo.dart';

class CreateEditTodoScreen extends StatefulWidget {
  final CreateEditTodoScreenData screenData;
  const CreateEditTodoScreen({Key? key, required this.screenData})
      : super(key: key);

  @override
  State<CreateEditTodoScreen> createState() => _CreateEditTodoScreenState();
}

class _CreateEditTodoScreenState extends State<CreateEditTodoScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.screenData.todoToEdit != null) {
      widget.screenData.nameController.text =
          widget.screenData.todoToEdit?.name ?? '';
      widget.screenData.descriptionController.text =
          widget.screenData.todoToEdit?.description ?? '';
      widget.screenData.tagController.text =
          widget.screenData.todoToEdit?.tag ?? '';
      widget.screenData.selectedDate = widget.screenData.todoToEdit?.date;
      widget.screenData.selectedPriority =
          widget.screenData.todoToEdit?.priority ?? Priority.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        children: [
          TextField(
            controller: widget.screenData.nameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Add name',
            ),
          ),
          TextField(
            controller: widget.screenData.descriptionController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Add description',
            ),
          ),
          TextField(
            controller: widget.screenData.tagController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Add tag',
            ),
          ),
          DateTimePicker(
            initialValue: widget.screenData.dateFormat
                .format(widget.screenData.selectedDate ?? DateTime.now()),
            firstDate: DateTime(2022),
            lastDate: DateTime(2100),
            dateLabelText: 'Date',
            onChanged: (date) =>
                widget.screenData.selectedDate = DateTime.tryParse(date),
          ),
          RadioGroup<Priority>.builder(
            groupValue: widget.screenData.selectedPriority,
            direction: Axis.horizontal,
            onChanged: (value) => setState(() {
              widget.screenData.selectedPriority = value ?? Priority.normal;
            }),
            items: widget.screenData.priority,
            itemBuilder: (item) =>
                RadioButtonBuilder(describeEnum(item).toUpperCase()),
          ),
          TextButton(
            onPressed: () {
              final Todo newTodo = Todo(
                id: widget.screenData.todoToEdit?.id ??
                    DateTime.now().millisecondsSinceEpoch,
                name: widget.screenData.nameController.text,
                priority: widget.screenData.selectedPriority,
                date: widget.screenData.selectedDate ?? DateTime.now(),
                tag: widget.screenData.tagController.text,
                description: widget.screenData.descriptionController.text,
              );

              Navigator.pop(context, newTodo);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class CreateEditTodoScreenData {
  Todo? todoToEdit;

  List<Priority> priority = Priority.values;
  Priority selectedPriority = Priority.normal;
  DateTime? selectedDate;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  DateFormat dateFormat = DateFormat("MMM d, yyyy");

  CreateEditTodoScreenData({this.todoToEdit});
}
