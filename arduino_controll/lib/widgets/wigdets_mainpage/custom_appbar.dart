import 'package:arduino_control/screens/mainpages/control_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget {
  final String title;
  String? skippingtext;
  Widget? whichpage;
  double? height;
  bool button;
  AppBarCustom({
    super.key,
    required this.title,
    required this.button,
    this.skippingtext,
    this.whichpage,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      surfaceTintColor: Colors.black,
      expandedHeight: height ?? 200,
      shadowColor: Colors.black,
      scrolledUnderElevation: 30,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(8),
        title: Text(title),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: button,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          whichpage ??
                          const ControlPage(
                            baseUrl: '',
                          ),
                    )),
                    child: Text('Skip to $skippingtext page'),
                  ),
                ),
                const SizedBox(height: 16), // Space below button
              ],
            ),
          ],
        ),
      ),
    );
  }
}
