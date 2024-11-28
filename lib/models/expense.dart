class Expense {
  final String description;
  final double amount;
  final String category;
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });

  @override
  String toString() {
    return 'Expense: $description\nAmount: \$${amount.toStringAsFixed(2)}\nCategory: $category\nDate: ${date.toString().split(' ')[0]}';
  }
}
