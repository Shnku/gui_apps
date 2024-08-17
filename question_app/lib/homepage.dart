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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: qustionList.length,
        itemBuilder: (context, i) {
          return Qustionwidget(index: i);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          evalResult();
          setState(() {});
        },
        child: Text('marks \n\t\t\t\t$gettedMarks'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
