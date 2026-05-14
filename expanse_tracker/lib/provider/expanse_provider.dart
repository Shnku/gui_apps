import 'package:expanse_tracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class TransactionProvider with ChangeNotifier {
  final _transactionBox = Hive.box('transaction_box');
  final List<Transaction> _transactionList = [];

  TransactionProvider() {
    loadTransactions();
  }

  List<Transaction> get transactionList => _transactionList;

  double get totalDeposit => _transactionList
      .where((data) => data.isDeposit)
      .fold(0, (sum, data) => sum + data.amount);

  double get totalWithdraw {
    double sum = 0;
    for (var data in _transactionList) {
      if (!data.isDeposit) {
        sum += data.amount;
      }
    }
    return sum;
  }

  double get totalBalance => totalDeposit - totalWithdraw;

  void saveToDB() {
    List<Map<String, dynamic>> data = _transactionList
        .map((transactionObject) => transactionObject.toMap())
        .toList();
    _transactionBox.put("transaction_box", data);
  }

  List<Transaction> getFromDB() {
    List<dynamic> data = _transactionBox.get(
      "transaction_box",
      defaultValue: [],
    );
    return data.map((map) {
      final safeMap = Map<String, dynamic>.from(map as Map);
      return Transaction.fromMap(safeMap);
    }).toList();
  }

  void loadTransactions() {
    List<Transaction> data = getFromDB();
    _transactionList.addAll(data);
    notifyListeners();
  }

  void refreshLocalstorage() {
    _transactionBox.clear();
  }

  void newTransaction(Transaction transaction) {
    _transactionList.add(transaction);
    saveToDB();
    notifyListeners();
  }

  void remTransaction(Transaction transaction) {
    _transactionList.remove(transaction);
    saveToDB();
    notifyListeners();
  }
}
