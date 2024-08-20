import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/main.dart';
import 'package:question_app/questiondata/qlist1.dart';
import 'package:question_app/questiondata/qlist2.dart';
import 'package:question_app/questiondata/qlist3.dart';
import 'package:question_app/managequestion/qustionwidget.dart';

import 'managequestion/selectdataset.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BoxDecoration boxDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.deepPurple.withAlpha(100),
      width: 5,
    ),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: Colors.black54,
        spreadRadius: 30,
        blurRadius: 50,
      )
    ],
    color: const Color.fromARGB(255, 62, 57, 105),
  );

  late QuestionSelector selected;

  @override
  void initState() {
    selected = QuestionSelector(qustionList: datalist1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            bottomOpacity: 3,
            backgroundColor: Colors.transparent,
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    return QuestionWidget(
                      index: i, questionSelector: selected,
                      // key: selected.selectdataset(i),
                    );
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext cb) => bottomSheet());
                    selected.evalResult();
                    setState(() {});
                  },
                  child: const Text('Get Score'),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
          drawer: Drawer(
            width: 220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _addtile(
                    datalist: selected.selectdataset(1),
                    text: 'Qustion sheet 1'),
                _addtile(
                    datalist: selected.selectdataset(2),
                    text: 'Qustion sheet 2'),
                _addtile(
                    datalist: selected.selectdataset(3),
                    text: 'Qustion sheet 3'),
              ],
            ),
          ),
          // Column( //not working......
          //   children: [
          //     SingleChildScrollView(
          //       scrollDirection: Axis.vertical,
          //       child: ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: qustionList.length,
          //         itemBuilder: (context, i) {
          //           return QuestionWidget(index: i);
          //         },
          //       ),
          //     ),
          //     const SizedBox(height: 50),
          //   ],
          // ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     evalResult();
          //     height = height == 200.0 ? 10.0 : 200.0;
          //     setState(() {});
          //   },
          //   child: Text('marks \n\t\t\t\t$gettedMarks'),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  ListTile _addtile({required List datalist, String? text}) {
    return ListTile(
      leading: const Icon(Icons.ac_unit),
      title: Text('$text'),
      onTap: () {
        selected = QuestionSelector(qustionList: datalist);
        setState(() {});
        Navigator.of(context).pop();
      },
    );
  }

  Container bottomSheet() {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: boxDecoration,
      height: 350,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${selected.gettedMarks} \nYour Marks ',
            textAlign: TextAlign.center,
            textScaler: const TextScaler.linear(1.8),
          ),
          Text(
            '${selected.totalmarks} \nTotal marks',
            textAlign: TextAlign.center,
            textScaler: const TextScaler.linear(1.8),
          ),
          ElevatedButton(
            onPressed: () {
              selected.resetAllQuestions();
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('ok', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pop();
            },
            child: const Text('Done', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
