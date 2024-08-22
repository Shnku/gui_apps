import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/main.dart';
import 'package:question_app/questiondata/qlist1.dart';
import 'package:question_app/questiondata/qlist2.dart';
import 'package:question_app/questiondata/qlist3.dart';
import 'package:question_app/managequestion/qustionwidget.dart';

import '../managequestion/selectdataset.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //get the screen width....
    double width = MediaQuery.sizeOf(context).width;
    const screenFactor = 700;

    // main wigdets ........
    Widget singleChildScrollView = ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: SingleChildScrollView(
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
                var count = 0;
                for (var element in questionKeys) {
                  if (element.currentState?.attemped == true) {
                    count++;
                  }
                }
                // print('count is $count');
                if (count >= questionKeys.length / 2) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext cb) => bottomSheet());
                  evalResult();
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      content: const Center(
                        child:
                            Text('You must Attemped more than Half Questions'),
                      ),
                      duration: const Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('Get Score'),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
    Widget drawer = Drawer(
      width: width < screenFactor ? 250 : 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          _addtile(datalist: datalist3, text: 'Qustion sheet 1'),
          _addtile(datalist: datalist2, text: 'Qustion sheet 2'),
          _addtile(datalist: datalist1, text: 'Qustion sheet 3'),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (width < screenFactor) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            label: const Text('Go Back'),
          )
        ],
      ),
    );
    var myappBar = AppBar(
      bottomOpacity: 3,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(widget.title),
      toolbarHeight: 50,
      automaticallyImplyLeading: width <= screenFactor ? true : false,
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
      ],
    );

    // building the layout....
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: myappBar,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= screenFactor) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: drawer),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width > 1400 ? 100 : 10),
                        child: singleChildScrollView,
                      ),
                    ),
                  ],
                );
              } else {
                return singleChildScrollView;
              }
            },
          ),
          drawer: width <= screenFactor ? drawer : null,
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
    );
  }

// list tile widget building function.........
  ListTile _addtile({required List datalist, String? text}) {
    var icon = Icons.no_accounts;
    bool isSelected = false;
    return ListTile(
      leading: Icon(icon),
      title: Text('$text'),
      // tileColor: Colors.blueGrey, //isSelected,
      // selectedTileColor: Colors.blue,
      // selected: isSelected,
      // selectedColor: Colors.white,
      onTap: () {
        qustionList = datalist;
        qustionList.shuffle();
        questionKeys = List.generate(
            qustionList.length, (index) => GlobalKey<QuestionWidgetstate>());
        resetAllQuestions();
        resetMarks();
        setState(() {
          isSelected = true;
          // isSelected = Colors.blueAccent;
          icon = Icons.one_k;
        });
        // Navigator.of(context).pop();
      },
    );
  }

// bootom sheet widget building function.........
  Container bottomSheet() {
    BoxDecoration boxDecoration = BoxDecoration(
      border: Border.all(
        color: Colors.deepPurple.withAlpha(80),
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
      color: const Color.fromARGB(87, 63, 57, 122),
    );

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
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('OK', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pop();
            },
            child: const Text('Go Home', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
