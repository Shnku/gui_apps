import 'package:flutter/material.dart';
import 'package:question_app/qustionsource.dart';

class Qustionwidget extends StatefulWidget {
  int index;
  @override
  State<Qustionwidget> createState() => _myQuestionWidget();
  Qustionwidget({super.key, required this.index});
}

class _myQuestionWidget extends State<Qustionwidget> {
  IconData ico = Icons.check_box_outline_blank;
  var iconDataList = [];
  List<bool> tapped = [];

  @override
  void initState() {
    iconDataList = [ico, ico, ico, ico];
    tapped = [false, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(137, 180, 136, 255),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${qustionList[widget.index]['q']}',
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black,
            height: 5,
            thickness: 3,
          ),
          _answerButton(0),
          _answerButton(1),
          _answerButton(2),
          _answerButton(3),
        ],
      ),
    );
  }

  TextButton _answerButton(int which) {
    return TextButton.icon(
      icon: Icon(iconDataList[which]),
      onPressed: () => _doOnPress(which),
      label: Text('${qustionList[widget.index]['a$which']}'),
    );
  }

  void _doOnPress(int choice) {
    print('in loop:$gettedMarks');
    for (int i = 0; i < 4; i++) {
      if (i == choice) {
        tapped[i] = true;
        iconDataList[i] = Icons.check_box;
        qustionList[widget.index]['marks'] = 'a$choice';
      } else {
        tapped[i] = false;
        iconDataList[i] = Icons.check_box_outline_blank;
        qustionList[widget.index]['marks'] = 'a$choice';
      }
    }

    print(qustionList[widget.index]);
    print(totalmarks);
    print(gettedMarks);
    setState(() {});
  }
}
