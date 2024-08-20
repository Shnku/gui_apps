// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:question_app/managequestion/qustionwidget.dart';
import 'package:question_app/questiondata/qlist1.dart';

List qustionList = datalist1;
int totalmarks = 5 * qustionList.length;
int gettedMarks = 0;
List<GlobalKey<QuestionWidgetstate>> questionKeys = List.generate(
    qustionList.length, (index) => GlobalKey<QuestionWidgetstate>());

void evalResult() {
  gettedMarks = 0;
  for (var element in qustionList) {
    print('${element['marks']}\t${element['correctAnswer']}');
    if (element['marks'] == element['correctAnswer']) {
      gettedMarks += 5;
    } else {
      // gettedMarks -= 5;
    }
  }
  print('evaluated marks=$gettedMarks');
}

void resetMarks() {
  for (var element in qustionList) {
    element['marks'] = "";
  }
  gettedMarks = 0;
  totalmarks = qustionList.length * 5;
}

void resetAllQuestions() {
  resetMarks();
  // questionKeys = List.generate(
  //     qustionList.length, (index) => GlobalKey<QuestionWidgetstate>());
  //can be putted here
  for (var key in questionKeys) {
    key.currentState?.toogleReset(); //dont use initState
  }
}
