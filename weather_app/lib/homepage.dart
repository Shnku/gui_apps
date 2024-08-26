import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/gettingdata.dart';

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
    try {
      await instance.getData();
      print(instance.temp);
      print(instance.iconUrl);
      setState(() {});
    } catch (error) {
      instance.cityData = 'no city name found';
      print("no search found/ error fetching $error");
      setState(() {
        // Update state to reflect the error (e.g., show an error message)
      });
    }
  }

  //initiation.....
  @override
  void initState() {
    super.initState();
    getter();
  }

  //design..........
  @override
  Widget build(BuildContext context) {
    TextEditingController fieldcontrol = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.transparent,
      //   title: Text(widget.title),
      //   toolbarHeight: 30,
      //   centerTitle: true,
      // ),
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
              Color.fromARGB(255, 17, 32, 43),
              Color.fromARGB(255, 43, 17, 43),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            //using silvers extend the coloumn to max height ..
            SliverFillRemaining(
              hasScrollBody: false,
              //sliver that fills the remaining space in the viewport.
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        // blendMode: BlendMode.difference,
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: TextField(
                          controller: fieldcontrol,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          textAlign: TextAlign.center,
                          onSubmitted: (value) {
                            print(value);
                            instance = GettedData(search: value);
                            getter();
                            fieldcontrol.clear();
                            // setState(() {});
                          },
                          decoration: const InputDecoration(
                            labelText: "search for a city",
                            prefixIcon: Icon(Icons.search_rounded),
                            filled: true,
                            fillColor: Color.fromARGB(150, 5, 5, 5),
                            // border: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text("🌎${instance.cityData}",
                      style: GoogleFonts.mPlus1(fontSize: 20)),
                  const SizedBox(height: 15),
                  Text(
                    "🌡️${instance.temp}°C",
                    style: GoogleFonts.b612(fontSize: 50),
                  ),
                  Text('max🔺${instance.max}°C,\t min🔻${instance.min}°C '),
                  Text("feels-like: ${instance.feelsLike}°C"),
                  const SizedBox(height: 10),
                  Card(
                    surfaceTintColor: Colors.black,
                    color: const Color.fromARGB(216, 1, 1, 1),
                    elevation: 30,
                    child: BackdropFilter(
                      blendMode: BlendMode.screen,
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Image.network(
                        instance.iconUrl.toString(),
                        height: 140,
                        width: 140,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          // Return a placeholder widget or error message
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                  Text(
                    (instance.conditions?['main']).toString(),
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  ),
                  Text((instance.conditions?['description']).toString()),
                  const SizedBox(height: 20),
                  FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          cardBuildHorizontal(
                            txt: (instance.wind?['speed']).toString(),
                            // ico: const Icon(Icons.air, size: 50),
                            ico: 'icones/wind-power.png',
                            unit:
                                '\n  Km/h\n (${getWindDirection(instance.wind?['deg'].toString())})',
                          ),
                          cardBuildHorizontal(
                            // ico: const Icon(Icons.health_and_safety_outlined,size: 50),
                            ico: 'icones/air-quality.png',
                            txt: instance.aqi,
                            unit: '\n  PPM\n (${aqidata[instance.aqi]})',
                          ),
                        ],
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cardBuild(
                          // ico: const Icon(Icons.visibility, size: 50),
                          ico: 'icones/visibility.png',
                          txt: instance.visibl.toString(),
                          unit: '%',
                        ),
                        cardBuild(
                          txt: instance.humidity.toString(),
                          // ico: const Icon(Icons.water_drop_outlined, size: 50),
                          ico: 'icones/humidity.png',
                          unit: '%',
                        ),
                        cardBuild(
                          txt: instance.pressure.toString(),
                          // ico: const Icon(Icons.speed_rounded, size: 50),
                          ico: 'icones/barometer.png',
                          unit: 'mBar',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Divider(
                    //   indent: 50,
                    endIndent: 50,
                    thickness: 0.1,
                    height: 0,
                  ),
                  const Text(
                    'powered by OpenWeather free API\ncreated by ShAnku',
                    style: TextStyle(fontSize: 9, color: Colors.white38),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card cardBuildHorizontal(
      {required String txt, required String ico, String? unit}) {
    return Card(
      color: const Color.fromARGB(255, 1, 1, 1),
      surfaceTintColor: Colors.white,
      elevation: 1,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        blendMode: BlendMode.difference,
        child: Container(
          height: 100,
          width: 185,
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(ico, scale: 10),
              Text(
                txt,
                style: GoogleFonts.alexandria(fontSize: 30),
              ),
              Text(unit.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Card cardBuild({required String txt, required String ico, String? unit}) {
    return Card(
      borderOnForeground: true,
      color: const Color.fromARGB(255, 1, 1, 1),
      surfaceTintColor: Colors.white,
      elevation: 1,
      child: BackdropFilter(
        blendMode: BlendMode.difference,
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          height: 135,
          width: 120,
          child: Column(
            children: [
              Image.asset(ico, scale: 10),
              const SizedBox(height: 10),
              Text(
                txt,
                style: GoogleFonts.alexandria(fontSize: 30),
              ),
              Text(unit.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
