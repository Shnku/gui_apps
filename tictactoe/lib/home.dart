import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var boxes = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
  var tapped = [false, false, false, false, false, false, false, false, false];
  String status = "";
  bool flag = false;
  int inserted = 0;

  // ignore: non_constant_identifier_names
  void val_input_logic(int indx) {
    if (!tapped[indx]) {
      flag = flag ? false : true;
      inserted++;
      boxes[indx] = flag ? "O" : "X";
      tapped[indx] = true;
      setState(() {});
    }
    status = chek_won(boxes);
    if (status == "WIN" || inserted == 9) {
      // Future.delayed(const Duration(seconds: 2), () {});
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 20,
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: Colors.blueGrey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            title: Text(inserted == 9
                ? status == "WIN"
                    ? "YOU WON"
                    : "DRAW"
                : "YOU WIN"),
            alignment: Alignment.center,
            content: const Text(
              "Do you want to play again?",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  reset(boxes, tapped); //this state is needed..
                  setState(() {
                    status = ""; //cant pass by referance
                    inserted = 0;
                  });
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          );
        },
      );
    }
  }

  Widget element(int which, {VoidCallback? tapped}) {
    //typedef VoidCallback = void Function()
    return InkWell(
      onTap: tapped ?? () => val_input_logic(which),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      splashFactory: InkSparkle.splashFactory,
      highlightColor: const Color.fromARGB(255, 71, 94, 222),
      splashColor: Colors.blue,
      hoverColor: Colors.black,
      focusColor: Colors.black,
      child: Container(
        alignment: Alignment.center,
        height: 170,
        width: 100,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.blueGrey.withAlpha(100),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Text(
          boxes[which] == "O" || boxes[which] == "X" ? boxes[which] : "",
          style: const TextStyle(fontSize: 30),
        ),
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
            FittedBox(
              child: Container(
                height: 390,
                width: 360,
                margin: const EdgeInsets.all(8),
                // color: Colors.amberAccent,
                child: GridView(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                    // mainAxisExtent: 80,
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
                    element(8)
                  ],
                ),
              ),
            ),
            Text('Home Page ::=>   ${flag.toString()} $inserted'),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: display(boxes, tapped),
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
      return "WIN";
    }
  }
  for (var i = 0; i < 3; i++) {
    if (arr[i] == arr[i + 3] &&
        arr[i + 3] == arr[i + 6] &&
        arr[i + 6] == arr[i] &&
        arr[i] != 0) {
      return "WIN";
    }
  }
  if (arr[0] == arr[4] && arr[4] == arr[8] && arr[4] != 0) {
    return "WIN";
  }
  if (arr[2] == arr[4] && arr[4] == arr[6] && arr[4] != 0) {
    return "WIN";
  }
  return "";
}

List<Widget> display(arr, tap) {
  return <Widget>[
    const Text("_________________________"),
    Text("${arr[0]}) ${tap[0]}   ${arr[1]}) ${tap[1]}   ${arr[2]}) ${tap[2]}"),
    Text("${arr[3]}) ${tap[3]}   ${arr[4]}) ${tap[4]}   ${arr[5]}) ${tap[5]}"),
    Text("${arr[6]}) ${tap[6]}   ${arr[7]}) ${tap[7]}   ${arr[8]}) ${tap[8]}"),
    const Text("_________________________")
  ];
}

void reset($arr, $tapped) {
  for (var i = 0; i < 9; i++) {
    $arr[i] = (i + 1).toString();
    $tapped[i] = false;
  }
}
