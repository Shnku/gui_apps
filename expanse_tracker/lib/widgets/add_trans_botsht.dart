import 'package:expanse_tracker/models/transaction.dart';
import 'package:expanse_tracker/provider/expanse_provider.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key, this.isDeposit = false});
  final bool? isDeposit;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    TextEditingController t1 = TextEditingController();
    TextEditingController t2 = TextEditingController();
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(
      context,
    );
    return GlassmorphicContainer(
      width: double.infinity,
      height: 500,
      borderRadius: 20,
      linearGradient: LinearGradient(
        colors: [
          const Color.fromARGB(169, 39, 31, 54),
          const Color.fromARGB(144, 49, 28, 58),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: 0,
      blur: 40,
      borderGradient: LinearGradient(
        colors: [
          const Color.fromARGB(74, 29, 29, 29),
          const Color.fromARGB(78, 46, 49, 78),
        ],
      ),

      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Comment'),
              controller: t1,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: t2,
              keyboardType: TextInputType.number,
            ),
            Spacer(flex: 4),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(3, (int index) {
                var _value;
                return ChoiceChip(
                  label: Text('Item $index'),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(flex: 4),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.pop(context);
                transactionProvider.newTransaction(
                  Transaction(
                    title: t1.text,
                    amount: double.tryParse(t2.text) ?? 0,
                    isDeposit: widget.isDeposit as bool,
                    date: DateTime.now(),
                    id: DateTime.now().toString(),
                  ),
                );
              },
              child: const Text('Add Transaction'),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
