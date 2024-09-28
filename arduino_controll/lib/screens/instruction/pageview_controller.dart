import 'package:arduino_control/screens/mainpages/ip_config.dart';
import 'package:flutter/material.dart';
import 'package:simple_page_indicator/simple_page_indicator.dart';

import 'pageviews/code_instructions.dart';

class InstructionPage extends StatefulWidget {
  const InstructionPage({super.key});

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              InitPage(),
              Step1(),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
              child: SimplePageIndicator(
                itemCount: 2,
                controller: _pageController,
                maxSize: 10,
                minSize: 6,
                indicatorColor: Colors.white,
                space: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
