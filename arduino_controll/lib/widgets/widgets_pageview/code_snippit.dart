import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/tomorrow-night.dart';

class CodeSnippit extends StatelessWidget {
  const CodeSnippit({
    super.key,
    required String codeSnippet,
  }) : _codeSnippet = codeSnippet;

  final String _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }
}
