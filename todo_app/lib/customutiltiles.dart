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
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Slidable(
        endActionPane: ActionPane(
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
        child: Row(
          children: [
            Checkbox(value: isDone, onChanged: onChanged),
            const SizedBox(width: 10),
            Text(
              data,
              style: TextStyle(
                fontSize: 20,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ],
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
      actions: [
        TextField(
          controller: textcontroller,
          onSubmitted: (value) => onPressed,
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('add'),
        )
      ],
      icon: const Icon(Icons.abc_outlined),
    );
  }
}
