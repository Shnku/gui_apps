import 'dart:developer';
import 'dart:io';

import 'package:arduino_control/widgets/wigdets_mainpage/custom_appbar.dart';
import 'package:arduino_control/screens/mainpages/control_page.dart';
import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _RootPageState();
}

class _RootPageState extends State<InitPage> {
  late String baseUrl = '192.168.29.0';
  final _formKey = GlobalKey<FormState>();
  static const labelText = 'Enter the IP address of Arduino';
  String _result = '';
  bool _resultStatus = false;

  final RegExp ipv4Regex = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
  );

  Future<void> _checkIP(String ip) async {
    debugPrint(ip.toString());
    try {
      // Attempt to create a socket connection to the IP on port 80
      final socket =
          await Socket.connect(ip, 80, timeout: const Duration(seconds: 5));
      socket.destroy();
      setState(() {
        _resultStatus = true;
        _result = 'IP $ip is reachable';
      });
    } catch (e) {
      log('ip not reachable');
      setState(() {
        _resultStatus = false;
        _result = 'IP $ip is not reachable';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      body: CustomScrollView(
        slivers: [
          AppBarCustom(
            title: 'Connect to Arduino',
            button: false,
            height: 250,
            skippingtext: 'Controlling',
          ),
          SliverFillRemaining(
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    minWidth: MediaQuery.sizeOf(context).width - 40,
                    height: 50,
                    color: Colors.blueGrey,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        setState(() => _result = 'Processing....');
                        _checkIP(baseUrl);
                      }
                    },
                    child: const Text('Check IP'),
                  ),
                  const SizedBox(height: 50),
                  Text(_result),
                  const SizedBox(height: 50),
                  Visibility(
                    visible: _resultStatus,
                    child: IconButton(
                      iconSize: 50,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ControlPage(baseUrl: baseUrl),
                        ),
                      ),
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
