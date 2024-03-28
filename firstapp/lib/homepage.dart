import "dart:math";
import "package:flutter/material.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  var operation = "";
  var result = "";
  TextStyle mytxt50 = TextStyle(fontSize: 50);
  TextStyle mytxt30 = TextStyle(fontSize: 35);
  BoxDecoration myboxdeco = BoxDecoration(
      border: Border.all(width: 1),
      boxShadow: [
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
    double width = 85,
    double height = 75,
    Function()? pressing,
  }) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(1),
      // color: Colors.black,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blue.withAlpha(50)),
          foregroundColor: MaterialStatePropertyAll(Colors.lightGreenAccent),
          side: MaterialStatePropertyAll(BorderSide(width: 0)),
          elevation: MaterialStateProperty.all(5),
          padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
        ),
        onPressed: pressing ?? () => setState(() => operation += symbol),
        child: icon ?? Text(symbol, style: mytxt30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 104, 161, 71),
      appBar: AppBar(
        title: Text("Calculator App"),
        toolbarHeight: 40,
        centerTitle: true,
        bottomOpacity: 0.5,
        forceMaterialTransparency: true,
        elevation: 2,
        shadowColor: Colors.green,
        backgroundColor: Color.fromARGB(255, 81, 116, 49),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 160,
              width: 390,
              decoration: myboxdeco,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(operation, style: mytxt50),
                    Container(
                        height: 1,
                        color: Colors.black,
                        alignment: Alignment.center),
                    Text(result, style: mytxt50)
                  ],
                ),
              ),
            ),
            Container(
              width: 390,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: myboxdeco,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          buildCalculatorButton("+",
                              icon: Icon(Icons.add, size: 40)),
                          buildCalculatorButton("-",
                              icon: Icon(Icons.remove, size: 40)),
                          buildCalculatorButton("*",
                              icon: Icon(Icons.close, size: 40)),
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
                              icon: Icon(Icons.backspace, size: 30)),
                        ],
                      ),
                    ],
                  ),
                  Column(children: [
                    buildCalculatorButton("/"),
                    buildCalculatorButton("^",
                        icon: Icon(Icons.expand_less, size: 40)),
                    buildCalculatorButton("AC",
                        pressing: () => setState(() {
                              operation = "";
                              result = "";
                            })),
                    buildCalculatorButton("=",
                        height: 153,
                        pressing: () => setState(() {
                              if (result.isNotEmpty) {
                                operation = result.substring(1);
                                result = "";
                              } else {
                                operation += "=";
                                result = "=${doCalculation(operation)}";
                                operation = operation.replaceAll("=", "");
                              }
                            })),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Created By ShAnku"),
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
    print("\t----${i}_ts_scan__${str[i]}");
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
          print(operators);
        } else {
          while (operators.isNotEmpty &&
              weight(operators.last) >= weight(str[i])) {
            print(operators);
            print(list);
            list.add(operators.removeLast());
            print(operators);
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
  print(list);
  print(operators);
  ans = evalExpr(list);
  print("ans is : $ans");
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
    print("eval exp stack is: $stk");
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
