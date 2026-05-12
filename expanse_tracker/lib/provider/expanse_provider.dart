import 'package:expanse_tracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class TransactionProvider with ChangeNotifier {
  final _transactionBox = Hive.box('transaction_box');
  final List<Transaction> _transaction_list = [];

  List<Transaction> get transaction_list => _transaction_list;

  double get totalDeposit => _transaction_list
      .where((data) => data.isDeposit)
      .fold(0, (sum, data) => sum + data.amount);

  double get totalWithdraw {
    double sum = 0;
    for (var data in _transaction_list) {
      if (!data.isDeposit) {
        sum += data.amount;
      }
    }
    return sum;
  }

  double get totalBalance => totalDeposit - totalWithdraw;

  void saveToDB() {
    List<Map<String, dynamic>> data = _transaction_list
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
    _transaction_list.addAll(data);
    notifyListeners();
  }

  void refreshLocalstorage() {
    _transactionBox.clear();
  }

  void newTransaction(Transaction transaction) {
    _transaction_list.add(transaction);
    saveToDB();
    notifyListeners();
  }

  void remTransaction(Transaction transaction) {
    _transaction_list.remove(transaction);
    saveToDB();
    notifyListeners();
  }
}
