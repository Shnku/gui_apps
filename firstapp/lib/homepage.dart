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
                                      operation += " - ";
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
                                operation += " \n= ${doCalculation(operation)}";
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

String doCalculation(String s) {
  String ans = '';
  String a = "", b = "", operator = "";
  bool flag = false;
  for (var i = 0; i < s.length; i++) {
    if (s[i] == "=") break;
    if (s[i] == "+" || s[i] == "-" || s[i] == "/" || s[i] == "*") {
      operator = s[i];
      flag = true;
    } else if (flag == false) {
      a += s[i];
    } else if (flag == true) {
      b += s[i];
    }
  }
  print(a);
  print(b);
  double n1 = double.parse(a);
  double n2 = double.parse(b);
  switch (operator) {
    case "+":
      ans = (n1 + n2).toString();
    case "-":
      ans = (n1 - n2).toString();
    case "*":
      ans = (n1 * n2).toString();
    case "/":
      ans = (n1 / n2).toString();
    default:
      ans = "wrong";
  }
  return ans;
}
