import 'package:hive_flutter/hive_flutter.dart';

class TasksDB {
  List tasksTodo = [];
  final box = Hive.box('mydb');

  //initiate.. for firat time creation..
  void initDb() {
    tasksTodo = [
      ['fuck off', false],
      ['just fuck off', false],
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
}
