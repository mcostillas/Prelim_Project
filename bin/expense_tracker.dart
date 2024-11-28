import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  // Create a ProviderContainer to manage the state
  final container = ProviderContainer();
  
  // Get the expense list notifier
  final expenseNotifier = container.read(expenseListProvider.notifier);
  
  // Example usage
  print('Expense Tracker Demo\n');
  
  // Add some sample expenses
  expenseNotifier.addExpense(
    Expense(
      id: '1',
      description: 'Groceries',
      amount: 50.0,
      date: DateTime.now(),
      category: 'Food',
    ),
  );
  
  expenseNotifier.addExpense(
    Expense(
      id: '2',
      description: 'Movie tickets',
      amount: 30.0,
      date: DateTime.now(),
      category: 'Entertainment',
    ),
  );
  
  // Print all expenses
  print('Current Expenses:');
  final expenses = container.read(expenseListProvider);
  for (final expense in expenses) {
    print('- ${expense.description}: \$${expense.amount} (${expense.category})');
  }
  
  // Print total expenses
  print('\nTotal Expenses: \$${expenseNotifier.getTotalExpenses()}');
  
  // Print expenses by category
  print('\nExpenses by Category:');
  final categoryTotals = expenseNotifier.getExpensesByCategory();
  categoryTotals.forEach((category, total) {
    print('$category: \$$total');
  });
}
