import 'package:expanse_tracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';

class TransactionProvider with ChangeNotifier {
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

  void newTransaction(Transaction transaction) {
    _transaction_list.add(transaction);
    notifyListeners();
  }

  void remTransaction(Transaction transaction) {
    _transaction_list.remove(transaction);
    notifyListeners();
  }
}
