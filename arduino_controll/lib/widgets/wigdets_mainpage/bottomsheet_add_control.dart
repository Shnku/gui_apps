import 'package:arduino_control/screens/instruction/pageviews/code_instructions.dart';
import 'package:flutter/material.dart';

class BottomAddControl extends StatelessWidget {
  void Function(String) onSubmitted;
  BottomAddControl({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    return Container(
      padding: EdgeInsets.all(20),
      height: 600,
      color: Colors.brown.withAlpha(10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text('ENTER  NEW  CONTROLLER  DETAILS'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Step1()))
            },
            child: Text('Check Instruction'),
          ),
          const SizedBox(height: 50),
          TextField(
              decoration: InputDecoration(hintText: 'Enter controller ID'),
              onSubmitted: (value) {
                onSubmitted(value);
                Navigator.of(context).pop();
              }),
          const SizedBox(height: 50),
          // ElevatedButton(
          //   onPressed: () => {Navigator.of(context).pop()},
          //   child: Text('add'),
          // ),
        ],
      ),
    );
  }
}

List children = [
  {'id': 'LED'},
];
