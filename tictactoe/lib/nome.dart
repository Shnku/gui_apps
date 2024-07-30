import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hallo"),
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 129, 114, 67),
          height: 400,
          width: 400,
          child: GridView.count(
            crossAxisCount: 6,
            childAspectRatio: 0.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(5),
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.amber,
                height: 50,
                width: 60,
                child: Card(child: Text("sajks")),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.amber,
                height: 50,
                width: 60,
                child: Text("sajks"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.amber,
                height: 50,
                width: 60,
                child: Text("sajks"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.amber,
                height: 50,
                width: 60,
                child: Text("sajks"),
              ),
              Container(
                color: Colors.amber,
                height: 50,
                width: 60,
                child: Text("sajks"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
