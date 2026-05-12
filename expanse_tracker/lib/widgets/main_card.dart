import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key, required this.value, required this.change});

  final double value;
  final double change;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            M3Container.pill(
              width: 150,
              height: 150,
              color: const Color.fromARGB(255, 76, 40, 134),
              clipBehavior: Clip.antiAlias,
              child: Icon(Icons.wallet, size: 90),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Text(
                  value.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Current Pocket Money",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Text(
              change.toStringAsFixed(2),
              style: TextStyle(
                color: change > 0 ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
