import 'package:flutter/material.dart';

class PinConfWidget extends StatelessWidget {
  final String id;
  final Function(String, String) onControlLED;
  const PinConfWidget({
    super.key,
    required this.id,
    required this.onControlLED,
  });

  SizedBox createButton({required String name, required String value}) {
    return SizedBox(
      height: 80,
      // width: ,
      child: MaterialButton(
        color: const Color.fromARGB(255, 53, 56, 58),
        // onPressed: () async {
        //   try {
        //     await controlLED(value);
        //   } catch (e) {
        //     if (mounted) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //           content: Text('no IP found+ $e'),
        //         ),
        //       );
        //     }
        //   }
        //   log(baseUrl);
        // },
        onPressed: () {
          debugPrint('........=Url=.........');
          onControlLED(name, value);
        },
        child: Text('Turn $name $value'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text('Config for pinmode {$id} '),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: createButton(name: id, value: 'ON')),
                  const SizedBox(width: 10),
                  Expanded(child: createButton(name: id, value: 'OFF')),
                ],
              ),
            ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
