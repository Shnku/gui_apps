import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MdInstructions extends StatelessWidget {
  const MdInstructions({
    super.key,
    required String markdownData,
  }) : _markdownData = markdownData;

  final String _markdownData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _markdownData.isNotEmpty
            ? Markdown(
                data: _markdownData,
                selectable: true,
               // physics: const NeverScrollableScrollPhysics(),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
