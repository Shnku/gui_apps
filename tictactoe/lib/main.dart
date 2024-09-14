import 'package:flutter/material.dart';
import 'package:tictactoe/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 134, 94, 245),
          onPrimary: Color.fromARGB(255, 135, 97, 240),
          secondary: Color(0xFF6750A4),
          onSecondary: Color(0xFF6750A4),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => const Loading(title: 'Loading'),
      //   '/home': (BuildContext context) => const HomePage(),
      // }
    );
  }
}

class Loading extends StatefulWidget {
  const Loading({super.key, required String title});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.pushReplacementNamed(context, '/');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Loading',
                style: TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(height: 20.0),
            SpinKitDoubleBounce(
              color: ThemeData.light().primaryColor,
              size: 80.0,
            )
          ],
        ),
      ),
    );
  }
}
