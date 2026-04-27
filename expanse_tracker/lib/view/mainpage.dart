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
            data: {
              "icon": Icons.account_balance_wallet,
              "value": transactionProvider.totalBalance.toStringAsFixed(2),
              "label": "Total Balance",
              "change": "+\$200",
            },
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: transactionProvider.transaction_list.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(transactionProvider.transaction_list[index].title),
                subtitle: Text(
                  "\$${transactionProvider.transaction_list[index].amount.toStringAsFixed(2)}",
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
