// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:question_app/managequestion/qustionwidget.dart';
import 'package:question_app/questiondata/qlist1.dart';
import 'package:question_app/questiondata/qlist2.dart';

import '../questiondata/qlist3.dart';

var questionSetList = [datalist1, datalist2, datalist3];

class QuestionSelector {
  late List qustionList;
  late int totalmarks;
  late int gettedMarks;

  QuestionSelector({required this.qustionList});

  List selectdataset(int indx) {
    indx--;
    qustionList = questionSetList[indx];
    gettedMarks = 0;
    totalmarks = qustionList.length * 5;
    return qustionList;
  }

  void resetAllQuestions() {
    List<GlobalKey<QuestionWidgetstate>> questionKeys = List.generate(
        qustionList.length, (index) => GlobalKey<QuestionWidgetstate>());
    for (var key in questionKeys) {
      key.currentState?.toogleReset(); //dont use initState
    }
  }

  void evalResult() {
    if (gettedMarks > 0) gettedMarks = 0;
    for (var element in qustionList) {
      print('${element['marks']}\t${element['correctAnswer']}');
      if (element['marks'] == element['correctAnswer']) {
        gettedMarks += 5;
      } else {
        // gettedMarks -= 5;
      }
    }
    print('gettingdata=$gettedMarks');
  }
}
