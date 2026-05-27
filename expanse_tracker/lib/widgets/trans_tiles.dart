import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class TransactionTile extends StatelessWidget {
  final Text amount;
  final Text comment;
  final Text date;

  const TransactionTile({
    super.key,
    required this.amount,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 65,
      margin: const EdgeInsetsDirectional.only(bottom: 5),
      borderRadius: 20,
      linearGradient: LinearGradient(
        colors: [
          const Color.fromARGB(43, 89, 86, 134),
          const Color.fromARGB(80, 68, 66, 78),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: 0,
      blur: 10,
      borderGradient: LinearGradient(colors: [Colors.black, Colors.black]),
      child: ListTile(
        leading: amount,
        title: Padding(
          padding: EdgeInsets.only(bottom: 3.0, left: 40),
          child: comment,
        ),
        trailing: date,
        // subtitle: comment,
        minVerticalPadding: 20,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        enableFeedback: true,
      ),
    );
  }
}
