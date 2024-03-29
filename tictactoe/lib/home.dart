import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var a = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
  String? s;
  bool flag = false;
  Widget element(int count, {VoidCallback? tapped}) {
    //typedef VoidCallback = void Function()
    return InkWell(
      onTap: tapped ??
          () {
            flag = flag ? false : true;
            setState(() {
              if (flag) {
                a[count] = "A";
              } else {
                a[count] = "B";
              }
              s = (chek_won(a).toString());
              if (s == "won") {
                Future.delayed(const Duration(seconds: 3), () {
                  reset(a);
                  setState(() {
                    s = null;
                  });
                });
              }
            });
          },
      splashFactory: InkSparkle.splashFactory,
      splashColor: Colors.blue,
      hoverColor: Colors.black,
      focusColor: Colors.black,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        color: Colors.red,
        child: Text(a[count],
            style: const TextStyle(
              fontSize: 30,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext concount) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              height: 360,
              color: Colors.amberAccent,
              child: GridView(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                children: [
                  element(0),
                  element(1),
                  element(2),
                  element(3),
                  element(4),
                  element(5),
                  element(6),
                  element(7),
                  element(8),
                ],
              ),
            ),
            Text('Home Page ::=>   ${flag.toString()}'),
            const SizedBox(height: 10),
            Text(s ?? "",
                style: TextStyle(fontSize: 30, color: Colors.red.shade900)),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: display(a),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
String chek_won(var arr) {
  for (var i = 0; i < 9; i += 3) {
    if (arr[i] == arr[i + 1] &&
        arr[i + 1] == arr[i + 2] &&
        arr[i + 2] == arr[i] &&
        arr[i] != 0) {
      return "won";
    }
  }
  for (var i = 0; i < 3; i++) {
    if (arr[i] == arr[i + 3] &&
        arr[i + 3] == arr[i + 6] &&
        arr[i + 6] == arr[i] &&
        arr[i] != 0) {
      return "won";
    }
  }
  if (arr[0] == arr[4] && arr[4] == arr[8] && arr[4] != 0) {
    return "won";
  }
  if (arr[2] == arr[4] && arr[4] == arr[6] && arr[4] != 0) {
    return "won";
  }
  return "null";
}

List<Widget> display(arr) {
  return <Widget>[
    const Text("____________________"),
    Text("${arr[0]}    ${arr[1]}    ${arr[2]}"),
    Text("${arr[3]}    ${arr[4]}    ${arr[5]}"),
    Text("${arr[6]}    ${arr[7]}    ${arr[8]}"),
    const Text("____________________")
  ];
}

void reset($arr) {
  for (var i = 0; i < 9; i++) {
    $arr[i] = (i + 1).toString();
  }
}
