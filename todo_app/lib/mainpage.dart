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
  var taskDone = 0;

  @override
  void initState() {
    _myBox.get('key') == null ? db.initDb() : db.loadDb();
    for (var element in db.tasksTodo) {
      if (element[1] == true) {
        taskDone++;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white70,
        forceMaterialTransparency: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height - 320,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: ListView.builder(
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
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            height: 40,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TaskDashboard(
                title: 'T A S K _ D O N E',
                taskDone: taskDone,
              ),
              TaskDashboard(
                title: 'R E M A I N I N G',
                taskDone: db.tasksTodo.length - taskDone,
              )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: _createTaskNew,
        tooltip: 'Add new task',
        icon: const Icon(Icons.add_circle_outline_outlined),
        label: const Text('New Task'),
        elevation: 30,
      ),
    );
  }

  void _onchange(indx) {
    db.tasksTodo[indx][1] = !db.tasksTodo[indx][1];
    setState(() {
      db.tasksTodo[indx][1] ? taskDone++ : taskDone--;
    });
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
    db.tasksTodo[indx][1] ? taskDone-- : null;
    db.tasksTodo.removeAt(indx);
    setState(() {});
    db.updateDb();
  }

  void _saveTask() {
    if (_textcontroller.text != '') {
      db.tasksTodo.add([_textcontroller.text, false]);
      _textcontroller.clear();
      setState(() {});
      Navigator.of(context).pop();
      db.updateDb();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Your task cant be empty'),
      ));
    }
  }
}
