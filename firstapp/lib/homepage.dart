// import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  var operation = "";
  TextStyle mytxt1 = TextStyle(fontSize: 50);
  TextStyle mytxt2 = TextStyle(fontSize: 30);
  String textfieldValue = "H";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 136, 202, 98),
      appBar: AppBar(
        title: Text("Calculator App"),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.green,
        backgroundColor: Color.fromARGB(255, 81, 116, 49),
        foregroundColor: Colors.white,
      ),
      body: Center(
        // child: Container(
        // alignment: AlignmentDirectional.center, //not work
        // transformAlignment: Alignment.center, //not work
        // width: 400,
        // color: Colors.grey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20),
              child: SizedBox(
                height: 150,
                width: 350,
                child: Card(
                  // margin: EdgeInsets.all(10.0),
                  color: Color.fromARGB(255, 103, 179, 137),
                  elevation: 15.0,
                  child: SingleChildScrollView(
                      reverse: true,
                      // scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          operation,
                          style: mytxt1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 340,
              child: Card(
                color: Color.fromARGB(255, 107, 150, 137),
                elevation: 15,
                // margin: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "/";
                                    },
                                  ),
                                  child: Text("/", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "*";
                                    },
                                  ),
                                  child: Text("*", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "-";
                                    },
                                  ),
                                  child: Text("-", style: mytxt2),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "1";
                                    },
                                  ),
                                  child: Text("1", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "2";
                                    },
                                  ),
                                  child: Text("2", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "3";
                                    },
                                  ),
                                  child: Text("3", style: mytxt2),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          height: 110,
                          width: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                operation += "+";
                              });
                            },
                            child: Text("+", style: mytxt2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "4";
                                    },
                                  ),
                                  child: Text("4", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "5";
                                    },
                                  ),
                                  child: Text("5", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "6";
                                    },
                                  ),
                                  child: Text("6", style: mytxt2),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "7";
                                    },
                                  ),
                                  child: Text("7", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "8";
                                    },
                                  ),
                                  child: Text("8", style: mytxt2),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation += "9";
                                    },
                                  ),
                                  child: Text("9", style: mytxt2),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 125,
                                  child: ElevatedButton(
                                    onPressed: () => setState(
                                      () {
                                        operation += "0";
                                      },
                                    ),
                                    child: Text("0", style: mytxt2),
                                  ),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () => setState(
                                    () {
                                      operation = "";
                                    },
                                  ),
                                  child: Text("AC", style: mytxt2),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          height: 165,
                          width: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                operation += "=";
                                String temp = doCalculation(operation);
                                operation = operation.replaceAll("=", '');
                                // List<String> t;
                                // t = operation.split("=");
                                // operation = t[0];
                                operation += "\n= $temp";
                              });
                            },
                            child: Text("=", style: mytxt2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text("created by ShAnku"),
          ],
        ),
        // ),
      ),
    );
  }
}

String doCalculation(String str) {
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
    if (str[i] == "+" || str[i] == "-" || str[i] == "/" || str[i] == "*") {
      list.add(temp);
      bool added = false;
      // list.add(str[i]);
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
  List<double> stk = [];
  for (var i = 0; i < exp.length; i++) {
    print("eval exp stack is: $stk");
    if (exp[i] == "+" || exp[i] == "-" || exp[i] == "/" || exp[i] == "*") {
      double n2 = stk.removeLast();
      double n1 = stk.removeLast();
      double ans = 0;
      switch (exp[i]) {
        case "+":
          ans = (n1 + n2);
        case "-":
          ans = (n1 - n2);
        case "*":
          ans = (n1 * n2);
        case "/":
          // if (n2 == 0) throw new IntegerDivisionByZeroException();
          ans = (n1 / n2);
        default:
          ans = 0;
      }
      stk.add(ans);
    } else {
      stk.add(double.parse(exp[i]));
    }
  }
  return stk.removeLast();
}
