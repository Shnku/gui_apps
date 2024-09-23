import 'dart:developer';
import 'dart:io';

import 'package:adruino_control_app/control_page.dart';
import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _RootPageState();
}

class _RootPageState extends State<InitPage> {
  late String baseUrl;
  final _formKey = GlobalKey<FormState>();
  static const labelText = 'Enter the IP address of Arduino';
  final RegExp ipv4Regex = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
  );

  String? _result;

  Future<void> _checkIP(String ip) async {
    debugPrint(ip.toString());
    try {
      // Attempt to create a socket connection to the IP on port 80
      final socket =
          await Socket.connect(ip, 80, timeout: const Duration(seconds: 5));
      socket.destroy();
      setState(() => _result = 'IP $ip is reachable');
    } catch (e) {
      log('ip not reachable');
      setState(() => _result = 'IP $ip is not reachable');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('How to Configure your Arduino'),
            surfaceTintColor: Colors.black,
            expandedHeight: 200,
            shadowColor: Colors.black,
            scrolledUnderElevation: 30,
            // forceMaterialTransparency: true,
          ),
          SliverFillRemaining(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.black45,
                        labelText: labelText,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'you must $labelText';
                        } else if (!ipv4Regex.hasMatch(value)) {
                          return 'That\'s not a valid IP Man';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        baseUrl = value;
                        debugPrint(baseUrl);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    color: Colors.blueGrey,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() => _result = 'Processing....');
                        _checkIP(baseUrl);
                      }
                    },
                    child: const Text('Check IP And Go'),
                  ),
                  const SizedBox(height: 50),
                  Text('$_result'),
                  Visibility(
                    visible: _result != null,
                    child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ControlPage(baseUrl: baseUrl),
                          )),
                      icon: const Icon(Icons.arrow_circle_right),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
