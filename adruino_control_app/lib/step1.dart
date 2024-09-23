import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/tomorrow-night.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  String _codeSnippet = '';
  @override
  void initState() {
    super.initState();
    _loadCodeSnippet();
  }

  Future<void> _loadCodeSnippet() async {
    String data = await rootBundle.loadString('assets/code_snippet.ino');
    setState(() {
      _codeSnippet = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              // scrollDirection: Axis.horizontal,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: HighlightView(
                  _codeSnippet,
                  tabSize: 16,
                  language: 'arduino',
                  theme: tomorrowNightTheme,
                  padding: const EdgeInsets.all(10),
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
