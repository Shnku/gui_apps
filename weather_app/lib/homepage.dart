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
    print(instance.iconUrl);
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        // title: Text(widget.title),
        toolbarHeight: 30,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.multiply,
            ),
            image: NetworkImage(
              bgimageIndex[(instance.conditions?['main']).toString()],
            ),
          ),
          gradient: const LinearGradient(
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    print(value);
                    instance = GettedData(search: value);
                    getter();
                    // setState(() {});
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    labelText: "search for a city",
                    filled: true,
                    fillColor: Color.fromARGB(50, 1, 1, 1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(instance.cityData.toString(),
                  style: GoogleFonts.alexandria(fontSize: 30)),
              const SizedBox(height: 20),
              Text(
                "${instance.temp} °C",
                style: GoogleFonts.overpass(fontSize: 50),
              ),
              Text("feels-like: ${instance.feelsLike} °C"),
              const SizedBox(height: 20),
              Card(
                color: const Color.fromARGB(30, 1, 1, 1),
                elevation: 50,
                child: Image.network(
                  instance.iconUrl?.toString() ??
                      "https://openweathermap.org/img/wn/10b@4x.png",
                  height: 140,
                  width: 140,
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
      color: const Color.fromARGB(60, 1, 1, 1),
      elevation: 50,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 30),
        height: 140,
        width: 120,
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
