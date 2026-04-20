import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.attach_money)),
      title: const Text('Grocery Shopping'),
      subtitle: const Text('2024-06-01'),
      trailing: const Text('-\$50.00', style: TextStyle(color: Colors.red)),
    );
  }
}
