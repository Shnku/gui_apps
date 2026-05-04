import 'package:expanse_tracker/models/transaction.dart';
import 'package:expanse_tracker/provider/expanse_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

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
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          height: 450,
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Label'),
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
                        amount: double.parse(t2.text),
                        isDeposit: true,
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
      },
    );
  }
}
