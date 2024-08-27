import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/customutiltiles.dart';
import 'package:todo_app/databsee.dart';

class Mainpage extends StatefulWidget {
  final String title;
  const Mainpage({super.key, required this.title});
  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final _myBox = Hive.box('mydb');
  TasksDB db = TasksDB();

  @override
  void initState() {
    if (_myBox.get('key') == null) {
      db.initDb();
    } else {
      db.loadDb();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: db.tasksTodo.length,
        itemBuilder: (context, index) {
          return MyTile(
            data: db.tasksTodo[index][0],
            isDone: db.tasksTodo[index][1],
            onChanged: (val) => _onchange(index),
            delete: (p0) => _deleteTile(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTaskNew,
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onchange(indx) {
    db.tasksTodo[indx][1] = !db.tasksTodo[indx][1];
    setState(() {});
    db.updateDb();
  }

  final _textcontroller = TextEditingController();
  void _createTaskNew() {
    showDialog(
      context: context,
      builder: (builder) {
        return MyDialog(
          textcontroller: _textcontroller,
          onPressed: _saveTask,
        );
      },
    );
  }

  void _deleteTile(int indx) {
    db.tasksTodo.removeAt(indx);
    setState(() {});
    db.updateDb();
  }

  void _saveTask() {
    db.tasksTodo.add([_textcontroller.text, false]);
    _textcontroller.clear();
    setState(() {});
    Navigator.of(context).pop();
    db.updateDb();
  }
}
