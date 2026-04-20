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
}
