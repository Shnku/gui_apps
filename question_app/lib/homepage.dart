import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/main.dart';
import 'package:question_app/qustionsource.dart';
import 'package:question_app/qustionwidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    color: const Color.fromARGB(255, 62, 57, 105),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
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
              itemCount: qustionList.length,
              itemBuilder: (context, i) {
                return QuestionWidget(
                  index: i,
                  key: questionKeys[i],
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext cb) => bottomSheet());
                evalResult();
                setState(() {});
              },
              child: const Text('Get Score'),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
      drawer: const Drawer(
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('Qustion sheet 1'),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('Qustion sheet 2'),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('Qustion sheet 3'),
            )
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
              Navigator.of(context).pop();
            },
            child: const Text('ok', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
