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
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
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
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: GlassmorphicContainer(
            width: double.maxFinite,
            height: double.maxFinite,
            borderRadius: 20,
            borderGradient: LinearGradient(
              colors: [
                const Color.fromARGB(0, 70, 66, 66),
                const Color.fromARGB(255, 71, 40, 119),
                const Color.fromARGB(169, 59, 58, 58),
              ],
            ),
            linearGradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 41, 24, 40),
                // const Color.fromARGB(255, 36, 34, 39),
                const Color.fromARGB(255, 28, 25, 48),
              ],
              transform: const GradientRotation(0.5),
            ),
            border: 1,
            blur: 100,

            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(child: const Text('Drawer Header')),
                const ListTile(title: Text('Item 1')),
                const ListTile(title: Text('Item 2')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
