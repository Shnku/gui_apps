import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data['icon'] as IconData, size: 24),
            const SizedBox(height: 8),
            Text(
              data['value'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              data['label'] as String,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              data['change'] as String,
              style: TextStyle(
                color: (data['change'] as String).startsWith('+')
                    ? Colors.green
                    : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
