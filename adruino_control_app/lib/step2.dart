import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  String _markdownData = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
  }

  Future<void> _loadMarkdown() async {
    String data = await rootBundle.loadString('assets/instructions.md');
    setState(() {
      _markdownData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('How to Configure your Arduino'),
            stretch: true,
            surfaceTintColor: Colors.black,
            expandedHeight: 200,
            shadowColor: Colors.black,
            scrolledUnderElevation: 30,
            // forceMaterialTransparency: true,
          ),
          SliverFillRemaining(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _markdownData.isNotEmpty
                    ? Markdown(data: _markdownData)
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
