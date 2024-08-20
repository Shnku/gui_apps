// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'selectdataset.dart';

class QuestionWidget extends StatefulWidget {
  int index;
  QuestionWidget({super.key, required this.index});

  @override
  State<QuestionWidget> createState() => QuestionWidgetstate();
}

class QuestionWidgetstate extends State<QuestionWidget> {
  var iconDataList = [];
  List<bool> tapped = [];
  late bool attemped;

  @override
  void initState() {
    toogleReset();
    super.initState();
  }

  void toogleReset() {
    setState(() {
      tapped = List.generate(4, (i) => false);
      iconDataList = List.generate(4, (i) => Icons.check_box_outline_blank);
      c = List.generate(4, (i) => Colors.black12);
      attemped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(117, 170, 87, 224),
        border: Border.all(
          color: const Color.fromARGB(99, 120, 84, 182),
          width: 4,
        ),
      ),
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('${widget.index + 1}'),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${qustionList[widget.index]['q']}',
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  late List c;
  Widget _answerButton(int which) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 2, 2, 3),
      child: TextButton.icon(
        iconAlignment: IconAlignment.end,
        onPressed: () => _doOnPress(which),
        icon: Icon(iconDataList[which]),
        label: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${which + 1})'),
            const SizedBox(width: 8),
            Expanded(
              child: Text('${qustionList[widget.index]['a$which']}'),
            ),
          ],
        ),
        style: TextButton.styleFrom(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          backgroundColor: c[which],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

  void _doOnPress(int choice) {
    setState(() {
      for (int i = 0; i < 4; i++) {
        attemped = true; //tapped means attempted.. no untap
        if (i == choice) {
          tapped[i] = true;
          iconDataList[i] = Icons.check_box;
          qustionList[widget.index]['marks'] = 'a$choice';
          c[i] = const Color.fromARGB(141, 125, 98, 201);
        } else {
          tapped[i] = false;
          iconDataList[i] = Icons.check_box_outline_blank;
          qustionList[widget.index]['marks'] = 'a$choice';
          c[i] = Colors.black12;
        }
      }
    });
    // print(qustionList[widget.index]);
    // print(totalmarks);
    // print(gettedMarks);
  }
}
