//custom dashboard for task counting.....
import 'package:flutter/material.dart';

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
