//my custom popup dialog to add task........
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
