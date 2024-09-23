import 'dart:developer';
import 'dart:io';
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
  var url;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arduino Control'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Config for 1st pinmode'),
            ),
            FittedBox(
              child: Row(children: [
                createButton(name: 'LED', value: 'ON'),
                const SizedBox(width: 10),
                createButton(name: 'LED', value: 'OFF'),
              ]),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  SizedBox createButton({required String name, required String value}) {
    return SizedBox(
      height: 70,
      width: 200,
      child: MaterialButton(
        color: Colors.blueGrey,
        // onPressed: () async {
        //   try {
        //     await controlLED(value);
        //   } catch (e) {
        //     if (mounted) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //           content: Text('no IP found+ $e'),
        //         ),
        //       );
        //     }
        //   }
        //   log(baseUrl);
        // },
        onPressed: () {
          controlLED(name, value);
          log('Url=$url');
          setState(() {});
        },
        child: Text('Turn $name $value'),
      ),
    );
  }
}
