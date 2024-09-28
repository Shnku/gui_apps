import 'package:arduino_control/widgets/wigdets_mainpage/custom_appbar.dart';
import 'package:arduino_control/widgets/widgets_pageview/code_snippit.dart';
import 'package:arduino_control/widgets/widgets_pageview/md_instructions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  String _codeSnippet = '';
  var _markdownData = '';
  bool _isExpand = false;

  @override
  void initState() {
    super.initState();
    _loadCodeSnippet();
  }

  Future<void> _loadCodeSnippet() async {
    String data = await rootBundle.loadString('assets/code_snippet.txt');
    String data2 = await rootBundle.loadString('assets/instructions.md');
    setState(() {
      _codeSnippet = data;
      _markdownData = data2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarCustom(
            title: 'How to configure Arduino Side Code',
            button: true,
            skippingtext: 'skippingtext',
            height: 350,
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => setState(() => _isExpand = !_isExpand),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Boilerplate Code',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (_isExpand)
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CodeSnippit(codeSnippet: _codeSnippet),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: MdInstructions(markdownData: _markdownData),
          ),
        ],
      ),
    );
  }
}
