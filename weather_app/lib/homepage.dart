import 'package:flutter/material.dart';
import 'package:weather_app/gettingdata.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //data fetching...........
  GettedData instance = GettedData(search: "hugli");
  getter() async {
    await instance.getData();
    print(instance.temp);
    print(instance.conditions?['icon']);
    setState(() {});
  }

  //initiation.....
  @override
  void initState() {
    super.initState();
    getter();
  }

  //desigh..........
  @override
  Widget build(BuildContext context) {
    TextEditingController fieldcontrol = TextEditingController();
    const inputDecoration = const InputDecoration(
        prefixIcon: Icon(Icons.search_rounded),
        labelText: "City Name",
        filled: true,
        fillColor: Color.fromARGB(50, 1, 1, 100),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   centerTitle: true,
      //   backgroundColor: const Color.fromARGB(255, 79, 165, 236),
      //   shadowColor: Colors.black,
      // ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 69, 171, 240),
              Color.fromARGB(255, 240, 90, 245),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 50,
                width: 400,
                // color: Colors.amber,
                child: TextField(
                  controller: fieldcontrol,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    print(value);
                    instance = GettedData(search: value);
                    getter();
                  },
                  decoration: inputDecoration,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 50,
                width: 300,
                alignment: Alignment.center,
                child: Text(instance.cityData.toString(),
                    style: GoogleFonts.alexandria(fontSize: 30)),
              ),
              Text(
                "${instance.temp} °C",
                style: GoogleFonts.overpass(fontSize: 40),
              ),
              Text("feels-like: ${instance.feelsLike} °C"),
              Card(
                color: const Color.fromARGB(30, 1, 1, 100),
                elevation: 50,
                child: Image.network(
                  "https://openweathermap.org/img/wn/${instance.conditions?['icon']}@4x.png",
                  height: 120,
                  width: 120,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                (instance.conditions?['main']).toString(),
                style: GoogleFonts.aBeeZee(fontSize: 20),
              ),
              Text((instance.conditions?['description']).toString()),
              const SizedBox(height: 50),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cardBuild(
                      txt: (instance.wind?['speed']).toString(),
                      ico: const Icon(Icons.air, size: 50),
                      unit: 'Km/h',
                    ),
                    cardBuild(
                      txt: instance.humidity.toString(),
                      ico: const Icon(Icons.water_drop_outlined, size: 50),
                      unit: '%',
                    ),
                    cardBuild(
                      ico: const Icon(Icons.av_timer_rounded, size: 50),
                      txt: instance.pressure.toString(),
                      unit: 'mBar',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Card cardBuild({required String txt, required Icon ico, String? unit}) {
    return Card(
      color: const Color.fromARGB(60, 50, 1, 150),
      elevation: 50,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 30),
        height: 140,
        width: 110,
        child: Column(
          children: [
            ico,
            const SizedBox(height: 10),
            Text(
              txt,
              style: GoogleFonts.amiko(fontSize: 30),
            ),
            Text(unit.toString()),
          ],
        ),
      ),
    );
  }
}
