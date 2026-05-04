import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final Text trailing;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.attach_money)),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
