import 'dart:convert';
import 'dart:developer';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:currency_converter/currency.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// class MyObject {
//   String countryname;
//   String countrycode;
//   String currency;
//   CountryFlag image;
//   MyObject.empty() : this('', '', '', CountryFlag.fromCountryCode(''));
//   MyObject(this.countryname, this.countrycode, this.currency, this.image);
// }

class _MyHomePageState extends State<MyHomePage> {
  // MyObject from = MyObject("india", "in", "INR", CountryFlag.fromCountryCode('in'));
  // MyObject to = MyObject("usa", "us", "USD", CountryFlag.fromCountryCode('us'));
  String display = '0';

  TextEditingController fieldcontrol = TextEditingController();
  TextEditingController fromcontrol = TextEditingController();
  TextEditingController tocontrol = TextEditingController();
  String fromC = '';
  String toC = "";

  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  //web fetching function.......
  Future fetchData(String base) async {
    Response response = await get(Uri.parse(
        'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$base.min.json'));
    if (response.statusCode == 200) {
      log(response.body);
    } else {
      throw ('Failed to fetch data');
    }
    Map<String, dynamic> data = jsonDecode(response.body);
    log("\ndata is: ");
    log(data[base]['inr']);
    return data;
  }

  @override
  initState() {
    super.initState();
    fieldcontrol.value = const TextEditingValue(text: "1");
    fromcontrol.value = const TextEditingValue(text: "US");
    tocontrol.value = const TextEditingValue(text: "IN");
    fromC = ctoc[fromcontrol.text].toString().toLowerCase();
    toC = ctoc[tocontrol.text].toString().toLowerCase();

    fetchData(fromC).then((data) {
      setState(() {
        display =
            "${fieldcontrol.text} $fromC = ${data[fromC][toC].toStringAsFixed(5).substring(0, 5)} $toC";
      });
    }).catchError((error) {
      log('Error fetching data: $error');
      // Handle the error (e.g., set an error state)
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // return GestureDetector(
    // onTap: () => FocusScope.of(context).unfocus(),
    // child: Scaffold(
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        elevation: BorderSide.strokeAlignOutside,
        centerTitle: true,
        toolbarHeight: 50,
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (isOn) {
              isOn
                  ? _toggleTheme(ThemeMode.dark)
                  : _toggleTheme(ThemeMode.light);
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.grey,
            activeTrackColor: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 20),
                  createcontainer("from", fromcontrol),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          var temp = fromcontrol.value;
                          fromcontrol.value = tocontrol.value;
                          tocontrol.value = temp;
                        });
                      },
                      icon: const Icon(Icons.swap_calls_outlined)),
                  createcontainer("to", tocontrol),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                display,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Divider(
                height: 2,
                color: Theme.of(context).primaryColor,
                thickness: 2,
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    fromC = ctoc[fromcontrol.text].toString().toLowerCase();
                    toC = ctoc[tocontrol.text].toString().toLowerCase();
                    try {
                      dynamic data = await fetchData(fromC);
                      setState(() {
                        display =
                            "${fieldcontrol.text} ${fromC.toUpperCase()} = ${(double.parse(fieldcontrol.text) * data[fromC][toC]).toStringAsFixed(2)} ${toC.toUpperCase()}";
                      });
                    } catch (error) {
                      log('Error fetching data: $error');
                      // Handle the error (e.g., set an error state)
                    }
                  },
                  child: const Text('Convert')),
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
              display = ("$display+$v").toString();
              // ico = geticon(tc.text);
            });
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
