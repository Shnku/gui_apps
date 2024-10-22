import 'package:country_flags/country_flags.dart';
import 'package:currency_converter/providermodel.dart';
import 'package:currency_converter/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/currency.dart';
import 'package:provider/provider.dart';

import 'barchartconfig.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController fieldcontrol = TextEditingController();
  TextEditingController fromcontrol = TextEditingController();
  TextEditingController tocontrol = TextEditingController();

  @override
  initState() {
    super.initState();
    fieldcontrol.value = const TextEditingValue(text: "1");
    fromcontrol.value = const TextEditingValue(text: "US");
    tocontrol.value = const TextEditingValue(text: "IN");
    context.read<DataProvider>().doCalculate(
        form: fromcontrol.text, to: tocontrol.text, val: fieldcontrol.text);
    /*
      trace of old logic..........
    */
    // fetchData(fromC).then((data) {
    //   setState(() {
    //     display =
    //         "${fieldcontrol.text} $fromC = ${data[fromC][toC].toStringAsFixed(5).substring(0, 5)} $toC";
    //   });
    // }).catchError((error) {
    //   log('Error fetching data: $error');
    // });
  }

  @override
  Widget build(BuildContext context) {
    bool isdark = context.watch<ThemeProvider>().themeMode == ThemeMode.dark;
    // return GestureDetector(
    // onTap: () => FocusScope.of(context).unfocus(),
    // child: Scaffold(
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
        toolbarHeight: 50,
        actions: [
          Switch(
            value: isdark,
            onChanged: (isOn) => context.read<ThemeProvider>().toggleTheme(),
            activeColor: Colors.deepPurple[100],
            inactiveThumbColor: Colors.purple[200],
            inactiveTrackColor: Colors.blue[200],
            activeTrackColor: Colors.indigo[500],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: !isdark
                  ? [
                      const Color.fromARGB(166, 89, 180, 255),
                      const Color.fromARGB(255, 219, 120, 237),
                    ]
                  : [
                      const Color.fromARGB(255, 7, 1, 90),
                      const Color.fromARGB(255, 93, 2, 121),
                    ],
              begin: Alignment.topLeft, // Gradient start point
              end: Alignment.bottomRight, // Gradient end point
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 120),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: fieldcontrol,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Amount",
                      labelText: "Amount"),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 30),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 20),
                    createcontainer("from", fromcontrol),
                    IconButton(
                      onPressed: () => setState(() {
                        var temp = fromcontrol.value;
                        fromcontrol.value = tocontrol.value;
                        tocontrol.value = temp;
                        context.read<DataProvider>().doCalculate(
                            form: fromcontrol.text,
                            to: tocontrol.text,
                            val: fieldcontrol.text);
                      }),
                      icon: const Icon(Icons.swap_calls_outlined),
                    ),
                    createcontainer("to", tocontrol),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<DataProvider>().doCalculate(
                      form: fromcontrol.text,
                      to: tocontrol.text,
                      val: fieldcontrol.text);
                },
                child: const Text('C O N V E R T'),
              ),
              const SizedBox(height: 40),
              Consumer<DataProvider>(
                builder: (ctx, value, _) => Text(
                  value.display ?? "nothing",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const Divider(
                height: 5,
                thickness: 0.4,
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(height: 20),
              ClipRRect(
                child: Container(
                  decoration: Mytheme.boxdeco,
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.fromLTRB(5, 20, 10, 3),
                  child: AspectRatio(
                    aspectRatio: 1.7,
                    child: Consumer<DataProvider>(
                      builder: (ctx, value, _) {
                        return BarChart(
                          getBarChartData(ctx),
                          swapAnimationDuration:
                              const Duration(milliseconds: 150),
                          swapAnimationCurve: Curves.easeIn,
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Container createcontainer(String txt, TextEditingController tc, {Color? c}) {
    return Container(
      // width: 130,
      // height: 60,
      child: (String txt, TextEditingController tc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DropdownMenu(
              controller: tc,
              hintText: txt,
              width: 140,
              leadingIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: geticon(tc.text),
              ),
              label: Text(txt),
              inputDecorationTheme: Theme.of(context).inputDecorationTheme,
              dropdownMenuEntries: ctoc.keys
                  .map(
                    (e) => DropdownMenuEntry(
                      value: e,
                      label: e,
                      leadingIcon: geticon(e),
                    ),
                  )
                  .toList(),
              onSelected: (v) {
                setState(() {
                  // display = ("$display+$v").toString();
                  // ico = geticon(tc.text);
                });
              },
            );
          },
        );
      }(txt, tc),
    );
  }

  CountryFlag geticon(String key, {double? height, double? width}) {
    return (CountryFlag.fromCountryCode(
      key,
      height: 30,
      width: 40,
      shape: const RoundedRectangle(5),
    ));
  }
}
