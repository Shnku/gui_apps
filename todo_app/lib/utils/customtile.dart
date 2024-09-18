import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class MyTile extends StatelessWidget {
  final String data;
  final dynamic isDone;
  final DateTime date;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? delete;

  const MyTile({
    super.key,
    required this.data,
    required this.isDone,
    required this.onChanged,
    required this.delete,
    required this.date,
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
              backgroundColor: const Color.fromARGB(255, 202, 0, 0),
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
              decoration:
                  isDone ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            // DateFormat('yyyy-MM-dd HH:mm:ss').format(date),
            DateFormat('HH:mm _ dd/MM/yy').format(date),
            textAlign: TextAlign.end,
            textScaler: const TextScaler.linear(0.7),
          ),
          // trailing: Text(TimeOfDay.now().toString()),
        ),
      ),
    );
  }
}
