class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isDeposit;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.isDeposit,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'isDeposit': isDeposit,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      isDeposit: map['isDeposit'],
    );
  }
}
