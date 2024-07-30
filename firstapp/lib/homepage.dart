import "dart:math";
import "package:flutter/material.dart";

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyCalculator> {
  var operation = "";
  var result = "";
  TextStyle mytxt50 = const TextStyle(fontSize: 50);
  TextStyle mytxt30 = const TextStyle(fontSize: 35);
  BoxDecoration myboxdeco = BoxDecoration(
      border: Border.all(width: 1),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      borderRadius: BorderRadius.circular(10));

  Widget buildCalculatorButton(
    String symbol, {
    Icon? icon,
    double width = 90,
    double height = 75,
    Function()? pressing,
  }) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(2),
      // color: Colors.black,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blue.withAlpha(50)),
          foregroundColor: const MaterialStatePropertyAll(Colors.greenAccent),
          side: const MaterialStatePropertyAll(BorderSide(width: 0)),
          elevation: MaterialStateProperty.all(5),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(2)),
        ),
        onPressed: pressing ?? () => setState(() => operation += symbol),
        child: icon ?? Text(symbol, style: mytxt30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 161, 71),
      appBar: AppBar(
        title: const Text("Calculator App"),
        toolbarHeight: 40,
        centerTitle: true,
        bottomOpacity: 0.5,
        forceMaterialTransparency: true,
        elevation: 2,
        shadowColor: Colors.green,
        backgroundColor: const Color.fromARGB(255, 81, 116, 49),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 160,
              width: 390,
              decoration: myboxdeco,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      operation,
                      style:mytxt50,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black,
                      // alignment: Alignment.center,
                    ),
                    Text(
                      result,
                      style: mytxt50,
                    )
                  ],
                ),
              ),
            ),
            FittedBox(
              child: Container(
                width: 390,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: myboxdeco,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            buildCalculatorButton("+",
                                icon: const Icon(Icons.add, size: 40)),
                            buildCalculatorButton("-",
                                icon: const Icon(Icons.remove, size: 40)),
                            buildCalculatorButton("*",
                                icon: const Icon(Icons.close, size: 40)),
                          ],
                        ),
                        Row(
                          children: [
                            buildCalculatorButton("1"),
                            buildCalculatorButton("2"),
                            buildCalculatorButton("3"),
                          ],
                        ),
                        Row(
                          children: [
                            buildCalculatorButton("4"),
                            buildCalculatorButton("5"),
                            buildCalculatorButton("6"),
                          ],
                        ),
                        Row(
                          children: [
                            buildCalculatorButton("7"),
                            buildCalculatorButton("8"),
                            buildCalculatorButton("9"),
                          ],
                        ),
                        Row(
                          children: [
                            buildCalculatorButton("."),
                            buildCalculatorButton("0"),
                            buildCalculatorButton("C",
                                pressing: () => setState(() => operation =
                                    operation.substring(0, operation.length - 1)),
                                icon: const Icon(Icons.backspace, size: 30)),
                          ],
                        ),
                      ],
                    ),
                    Column(children: [
                      buildCalculatorButton("/"),
                      buildCalculatorButton("^",
                          icon: const Icon(Icons.expand_less, size: 40)),
                      buildCalculatorButton("AC",
                          pressing: () => setState(() {
                                operation = "";
                                result = "";
                              })),
                      buildCalculatorButton("=",
                          height: 153,
                          pressing: () => setState(() {
                            
                                operation += "=";
                                result = "=${doCalculation(operation)}";
                                operation = operation.replaceAll("=", "");
                              }))
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Created By ShAnku"),
          ]),
        ),
      ),
    );
  }
}

String doCalculation(String str) {
  // ignore: prefer_typing_uninitialized_variables
  var ans;
  var list = [];
  var operators = []; // new List.empty();
  var temp = "";
  bool flag = false;
  for (var i = 0; i < str.length; i++) {
    if (str[i] == "=") {
      list.add(temp);
      list.addAll(operators.reversed);
      break;
    }
    if (str[i] == "+" ||
        str[i] == "-" ||
        str[i] == "/" ||
        str[i] == "*" ||
        str[i] == "^") {
      list.add(temp);
      bool added = false;
      if (operators.isNotEmpty) {
        if (weight(operators.last) < weight(str[i])) {
          operators.add(str[i]);
          added = true;
        } else {
          while (operators.isNotEmpty &&
              weight(operators.last) >= weight(str[i])) {
            list.add(operators.removeLast());
          }
        }
      }
      flag = true;
      added ? null : operators.add(str[i]);
      // continue;
    }
    if (flag == false) {
      temp += str[i];
    }
    if (flag == true) {
      temp = "";
      flag = false;
    }
  }
  ans = evalExpr(list);
  return (ans.toString());
}

int weight(var x) {
  int v = 0;
  switch (x) {
    case "+":
    case "-":
      return 3;
    case "*":
    case "/":
      return 5;
    case "^":
      return 7;
  }
  return v;
}

dynamic evalExpr(var exp) {
  List<num> stk = [];
  for (var i = 0; i < exp.length; i++) {
    // if (exp[i] == "=") break;
    if (exp[i] == "+" ||
        exp[i] == "-" ||
        exp[i] == "/" ||
        exp[i] == "*" ||
        exp[i] == "^") {
      num n2 = stk.removeLast();
      num n1 = stk.removeLast();
      num ans = 0;
      switch (exp[i]) {
        case "+":
          ans = (n1 + n2);
        case "-":
          ans = (n1 - n2);
        case "*":
          ans = (n1 * n2);
        case "/":
          ans = (n1 / n2);
        case "^":
          ans = pow(n1, n2);
        default:
          ans = 0;
      }
      stk.add(ans);
    } else {
      stk.add(num.parse(exp[i]));
    }
  }
  return stk.removeLast();
}
