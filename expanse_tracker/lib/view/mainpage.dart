import 'package:expanse_tracker/provider/expanse_provider.dart';
import 'package:expanse_tracker/widgets/add_trans_botsht.dart';
import 'package:expanse_tracker/widgets/main_card.dart';
import 'package:expanse_tracker/widgets/trans_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    provider.loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Expanse Tracker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MainCard(
            value: transactionProvider.totalDeposit,
            change: transactionProvider.totalBalance,
          ),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 2),
              shrinkWrap: true,
              itemCount: transactionProvider.transaction_list.length,
              itemBuilder: (context, index) => TransactionTile(
                title: Text(transactionProvider.transaction_list[index].title),
                subtitle: Text(
                  "${transactionProvider.transaction_list[index].date}",
                ),
                trailing: Text(
                  transactionProvider.transaction_list[index].isDeposit
                      ? '+\$${transactionProvider.transaction_list[index].amount.toStringAsFixed(2)}'
                      : '-\$${transactionProvider.transaction_list[index].amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: transactionProvider.transaction_list[index].isDeposit
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ),
          ),
          const Center(child: Text('Hello World')),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTransaction(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
