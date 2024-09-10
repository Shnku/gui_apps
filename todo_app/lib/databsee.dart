import 'package:hive_flutter/hive_flutter.dart';

class TasksDB {
  List tasksTodo = [];
  final box = Hive.box('mydb');

  //initiate.. for firat time creation..
  void initDb() {
    tasksTodo = [
      ['fuck off', 2],
      ['just fuck off', 1],
    ];
  }

  //add/del => update complete List..
  void updateDb() {
    box.put('key', tasksTodo);
  }

  //load previous data..//!to tasksTodo..
  void loadDb() {
    tasksTodo = box.get('key');
  }

  //short using count sort...
  void sortDb(String? tag) {
    List arr = [null];
    arr.addAll(tasksTodo);
    List<int> b = [0, 0, 0];
    List c = [null];

    for (var i = 1; i < arr.length; i++) {
      b[arr[i][1]]++;
      c.add(0);
    }
    for (var i = 1; i < b.length; i++) {
      b[i] = b[i - 1] + b[i];
    }
    for (var i = arr.length - 1; i > 0; i--) {
      c[b[arr[i][1]]] = arr[i];
      b[arr[i][1]]--;
    }
    List.copyRange(tasksTodo, 0, c, 1);
    if (tag! == 'r') {
      tasksTodo = (tasksTodo.reversed).toList();
    }
  }
}
