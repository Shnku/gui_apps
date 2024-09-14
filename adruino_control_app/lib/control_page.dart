import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late String baseUrl;

  Future<void> controlLED(String state) async {
    var url = Uri.parse('http://$baseUrl/LED=$state');

    /* If controlLED makes a network request that can throw an exception (like a SocketException), 
    you should handle that within the function itself or ensure that the calling code properly awaits the function.
    ?thats why when calling the function make it async.. insted of doing here..
    */
    // try {

    final response = await http.get(url);
    if (response.statusCode == 200) {
      log("Host is reachable: $url");
    } else {
      log("Host responded with status: ${response.statusCode}");
      throw Exception();
    }

    // } on SocketException {
    //   // Show Snackbar if there is no host
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("No host found for IP: $url")),
    //   );
    // } catch (e) {
    //   // Handle other exceptions
    //   debugPrint("An error occurred: $e");
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("An error occurred: $e")),
    //   );
    // }
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
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black45,
                labelText: 'Enter the IP address of Arduino',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                baseUrl = value;
                log(baseUrl);
                debugPrint(baseUrl);
              },
            ),
            const SizedBox(height: 50),
            createButton('ON'),
            const SizedBox(height: 20),
            createButton('OFF'),
          ],
        ),
      ),
    );
  }

  SizedBox createButton(String value) {
    return SizedBox(
      height: 70,
      width: 200,
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black45),
          elevation: WidgetStatePropertyAll(15),
        ),
        onPressed: () async {
          try {
            await controlLED(value);
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('no IP found+ $e'),
                ),
              );
            }
          }
          log(baseUrl);
        },
        child: Text('Turn LED $value'),
      ),
    );
  }
}
