import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//my custom tiles..........
class MyTile extends StatelessWidget {
  final String data;
  final dynamic isDone;
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
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            data,
            style: TextStyle(
              fontSize: 17,
              decoration: isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable //my custom popup dialog to add task........
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
      shadowColor: Theme.of(context).colorScheme.secondary,
      insetPadding: const EdgeInsets.all(15),
      actionsPadding: const EdgeInsets.all(20),
      actionsOverflowButtonSpacing: 25,
      elevation: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 0.5,
        ),
      ),
      actions: [
        TextField(
          controller: textcontroller,
          onSubmitted: (value) => onPressed,
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('add'),
        ),
      ],
    );
  }
}

//custom dashboard for task counting.....
class TaskDashboard extends StatelessWidget {
  final String title;
  final int taskDone;
  final Color color;
  final Function() onTap;

  const TaskDashboard({
    super.key,
    required this.taskDone,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      highlightColor: color,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          border: Border.all(color: color.withAlpha(100)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            '$title\n$taskDone',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
