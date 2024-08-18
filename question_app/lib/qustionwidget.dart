// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:question_app/qustionsource.dart';

class QuestionWidget extends StatefulWidget {
  int index;
  QuestionWidget({super.key, required this.index});

  @override
  State<QuestionWidget> createState() => QuestionWidgetstate();
}

class QuestionWidgetstate extends State<QuestionWidget> {
  var iconDataList = [];
  List<bool> tapped = [];

  @override
  void initState() {
    toogleReset();
    super.initState();
  }

  void toogleReset() {
    setState(() {
      tapped = List.generate(4, (i) => false);
      iconDataList = List.generate(4, (i) => Icons.check_box_outline_blank);
      c = List.generate(4, (i) => const Color.fromARGB(0, 44, 19, 19));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(137, 180, 136, 255),
        border: Border.all(
          color: Colors.deepPurple.withAlpha(100),
          width: 4,
        ),
      ),
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${widget.index + 1}. ${qustionList[widget.index]['q']}'),
          const Divider(
            color: Colors.black,
            height: 25,
            thickness: 2,
          ),
          _answerButton(0),
          _answerButton(1),
          _answerButton(2),
          _answerButton(3),
        ],
      ),
    );
  }

  List c = List.generate(4, (int i) => const Color.fromARGB(0, 44, 19, 19));
  TextButton _answerButton(int which) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        surfaceTintColor: Colors.amber,
        backgroundColor: c[which],
      ),
      icon: Icon(iconDataList[which]),
      iconAlignment: IconAlignment.end,
      onPressed: () => _doOnPress(which),
      label: Text(
        '${which + 1}) ${qustionList[widget.index]['a$which']}',
      ),
    );
  }

  void _doOnPress(int choice) {
    print('in loop:$gettedMarks');
    for (int i = 0; i < 4; i++) {
      if (i == choice) {
        tapped[i] = true;
        iconDataList[i] = Icons.check_box;
        qustionList[widget.index]['marks'] = 'a$choice';
        c[i] = Colors.purple[300];
      } else {
        tapped[i] = false;
        iconDataList[i] = Icons.check_box_outline_blank;
        qustionList[widget.index]['marks'] = 'a$choice';
        c[i] = Colors.transparent;
      }
    }
    print(qustionList[widget.index]);
    print(totalmarks);
    print(gettedMarks);
    setState(() {});
  }
}
