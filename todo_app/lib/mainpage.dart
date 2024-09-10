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

// ignore: constant_identifier_names
const DONE = 1, UN_DONE = 2;

class _MainpageState extends State<Mainpage> {
  final _myBox = Hive.box('mydb');
  TasksDB db = TasksDB();
  var taskDone = 0;

  @override
  void initState() {
    _myBox.get('key') == null ? db.initDb() : db.loadDb();
    for (var element in db.tasksTodo) {
      if (element[1] == DONE) {
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
            height: MediaQuery.sizeOf(context).height - 300,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: ListView.builder(
              itemCount: db.tasksTodo.length,
              itemBuilder: (context, index) {
                return MyTile(
                  data: db.tasksTodo[index][0],
                  isDone: db.tasksTodo[index][1] == DONE ? true : false,
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
                onTap: () => setState(() => db.sortDb('')),
                title: 'C O M P L E T E D',
                taskDone: taskDone,
                color: const Color.fromARGB(255, 96, 243, 38),
              ),
              TaskDashboard(
                onTap: () => setState(() => db.sortDb('r')),
                title: 'R E M A I N I N G',
                color: const Color.fromARGB(255, 255, 0, 0),
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
    db.tasksTodo[indx][1] = (db.tasksTodo[indx][1] == DONE ? UN_DONE : DONE);
    setState(() {
      db.tasksTodo[indx][1] == DONE ? taskDone++ : taskDone--;
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
    db.tasksTodo[indx][1] == DONE ? taskDone-- : null;
    db.tasksTodo.removeAt(indx);
    setState(() {});
    db.updateDb();
  }

  void _saveTask() {
    if (_textcontroller.text != '') {
      db.tasksTodo.add([_textcontroller.text, UN_DONE]); //!must be undone
      _textcontroller.clear();
      setState(() {});
      Navigator.of(context).pop();
      db.updateDb();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Your task cant be empty',
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ));
    }
  }
}
