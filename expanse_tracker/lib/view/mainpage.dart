import 'package:expanse_tracker/provider/expanse_provider.dart';
import 'package:expanse_tracker/widgets/add_trans_botsht.dart';
import 'package:expanse_tracker/widgets/main_card.dart';
import 'package:expanse_tracker/widgets/trans_tiles.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
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
    return GlassmorphicContainer(
      width: double.infinity,
      height: double.infinity,
      borderRadius: 0,
      linearGradient: LinearGradient(
        colors: [
          const Color.fromARGB(151, 94, 50, 91),
          const Color.fromARGB(144, 81, 81, 110),
          const Color.fromARGB(144, 103, 95, 150),
        ],
      ),
      border: 0,
      blur: 50,
      borderGradient: LinearGradient(
        colors: [Colors.transparent, Colors.transparent],
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Expanse Tracker'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MainCard(
              value: transactionProvider.totalDeposit,
              change: transactionProvider.totalBalance,
            ),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(117, 14, 12, 12),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: double.infinity,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 2),
                  shrinkWrap: true,
                  itemCount: transactionProvider.transactionList.length,
                  itemBuilder: (context, index) => TransactionTile(
                    comment: Text(
                      transactionProvider.transactionList[index].title,
                    ),
                    date: Text(
                      "${transactionProvider.transactionList[index].date}",
                    ),
                    amount: Text(
                      transactionProvider.transactionList[index].isDeposit
                          ? '+\$${transactionProvider.transactionList[index].amount.toStringAsFixed(2)}'
                          : '-\$${transactionProvider.transactionList[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            transactionProvider.transactionList[index].isDeposit
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(child: Text('Hello, Add your transactions!')),
          ],
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => AddTransaction(),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
