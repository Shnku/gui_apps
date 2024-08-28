import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//my custom tiles..........
class MyTile extends StatelessWidget {
  final String data;
  final bool isDone;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? delete;

  const MyTile({
    super.key,
    required this.data,
    required this.isDone,
    required this.onChanged,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(17, 13, 17, 0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.31,
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: delete,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: ListTile(
          leading: Checkbox(
            value: isDone,
            onChanged: onChanged,
            activeColor: Colors.deepPurple[300],
          ),
          title: Text(
            data,
            style: TextStyle(
              fontSize: 20,
              decoration:
                  isDone ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

//my custom popup dialog to add task........
class MyDialog extends StatelessWidget {
  void Function()? onPressed;
  var textcontroller = TextEditingController();

  MyDialog({
    super.key,
    required this.onPressed,
    required this.textcontroller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.add_task_outlined),
      shadowColor: Colors.deepPurple[200],
      insetPadding: const EdgeInsets.all(15),
      actionsPadding: const EdgeInsets.all(20),
      actionsOverflowButtonSpacing: 15,
      elevation: 25,
      actions: [
        TextField(
          controller: textcontroller,
          // onSubmitted: (value) => onPressed,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter some text'; // Validation message
          //   }
          //   return null; // Return null if the input is valid
          // },
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('add'),
        ),
      ],
    );
  }
}
