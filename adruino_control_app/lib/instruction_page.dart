import 'package:adruino_control_app/init_page.dart';
import 'package:adruino_control_app/step1.dart';
import 'package:adruino_control_app/step2.dart';
import 'package:flutter/material.dart';
import 'package:simple_page_indicator/simple_page_indicator.dart';

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
              Step1(),
              Step2(),
              InitPage(),
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
                  colors: [Colors.grey, Colors.transparent],
                ),
              ),
              child: SimplePageIndicator(
                itemCount: 3,
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
