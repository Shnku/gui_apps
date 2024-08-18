import 'package:flutter/material.dart';
import 'package:question_app/qustionsource.dart';
import 'package:question_app/qustionwidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var len = 10.0;
  List<GlobalKey<QuestionWidgetstate>> questionKeys = List.generate(
      qustionList.length, (index) => GlobalKey<QuestionWidgetstate>());

  void resetAllQuestions() {
    for (var key in questionKeys) {
      key.currentState?.toogleReset(); //dont use initState
    }
  }

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
    color: Colors.purple[100],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: qustionList.length,
              itemBuilder: (context, i) {
                return QuestionWidget(
                  index: i,
                  key: questionKeys[i],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  evalResult();
                  len = 300.0;
                  setState(() {});
                },
                child: const Text('Get Score')),
            const SizedBox(height: 90),
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

      bottomSheet: Container(
        padding: const EdgeInsets.all(50),
        decoration: boxDecoration,
        height: len,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$gettedMarks \nYour Marks ',
              textAlign: TextAlign.center,
              textScaler: const TextScaler.linear(1.8),
            ),
            Text(
              '$totalmarks \nTotal marks',
              textAlign: TextAlign.center,
              textScaler: const TextScaler.linear(1.8),
            ),
            ElevatedButton(
              onPressed: () {
                resetAllQuestions();
                setState(() {
                  len = 10.0;
                });
              },
              child: const Text('ok', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
