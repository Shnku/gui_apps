import 'dart:developer';
import 'dart:io';
import 'package:arduino_control/widgets/wigdets_mainpage/bottomsheet_add_control.dart';
import 'package:arduino_control/widgets/wigdets_mainpage/custom_appbar.dart';
import 'package:arduino_control/widgets/wigdets_mainpage/pin_conf_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlPage extends StatefulWidget {
  final String baseUrl;
  const ControlPage({super.key, required this.baseUrl});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  String get baseUrl => widget.baseUrl; //gatter
  late Uri url;

  Future<void> controlLED(String name, String state) async {
    // var url = Uri.parse('http://$baseUrl/LED=$state');
    // var url = Uri.parse('$baseUrl/LED=$state');
    // var url = Uri.parse('192.168.1.4/LED=$state');
    url = Uri.parse('http://$baseUrl/$name=$state');
    debugPrint(url.toString());

    /* If controlLED makes a network request that can throw an exception (like a SocketException), 
    you should handle that within the function itself or ensure that the calling code properly awaits the function.
    ?thats why when calling the function make it async.. insted of doing here..
    */
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        log("Host is reachable: $url");
      } else {
        log("Host responded with status: ${response.statusCode}");
        throw Exception();
      }
    } on SocketException {
      // Show Snackbar if there is no host
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No host found for IP: $url")),
        );
      }
    } catch (e) {
      // Handle other exceptions
      debugPrint("An error occurred: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }

  List children = [
    {'id': 'LED'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarCustom(title: 'Main', button: false),
          SliverFixedExtentList.builder(
            itemCount: children.length,
            itemBuilder: (BuildContext context, int index) {
              return PinConfWidget(
                id: children[index]['id'],
                onControlLED: controlLED,
              );
            },
            itemExtent: 130,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new pin-config',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => BottomAddControl(
              onSubmitted: (value) {
                children.add({'id': value});
                setState(() {});
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
