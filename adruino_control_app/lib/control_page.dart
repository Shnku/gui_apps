import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late String baseUrl = '192.168.1.4';

  Future<void> controlLED(String name, String state) async {
    // var url = Uri.parse('http://$baseUrl/LED=$state');
    // var url = Uri.parse('$baseUrl/LED=$state');
    // var url = Uri.parse('192.168.1.4/LED=$state');
    var url = Uri.parse('http://$baseUrl/$name=$state');
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
            TextField(
              // autofocus: true,
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
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Config for 1st pinmode'),
            ),
            FittedBox(
              child: Row(children: [
                createButton(name: 'LED1', value: 'ON'),
                const SizedBox(width: 10),
                createButton(name: 'LED1', value: 'OFF'),
              ]),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Config for 2nd pinmode'),
            ),
            FittedBox(
              child: Row(children: [
                createButton(name: 'LED2', value: 'ON'),
                const SizedBox(width: 10),
                createButton(name: 'LED2', value: 'OFF'),
              ]),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Config for 3rd pinmode'),
            ),
            FittedBox(
              child: Row(children: [
                createButton(name: 'LED3', value: 'ON'),
                const SizedBox(width: 10),
                createButton(name: 'LED3', value: 'OFF'),
              ]),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Config for 4th pinmode'),
            ),
            FittedBox(
              child: Row(children: [
                createButton(name: 'LED4', value: 'ON'),
                const SizedBox(width: 10),
                createButton(name: 'LED4', value: 'OFF'),
              ]),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Config for 5th pinmode'),
            ),
            FittedBox(
              child: Row(children: [
                createButton(name: 'LED5', value: 'ON'),
                const SizedBox(width: 10),
                createButton(name: 'LED5', value: 'OFF'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox createButton({required String name, required String value}) {
    return SizedBox(
      height: 70,
      width: 200,
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black),
          elevation: WidgetStatePropertyAll(15),
        ),
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
          log(baseUrl);
          setState(() {});
        },

        child: Text('Turn $name $value'),
      ),
    );
  }
}
