import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'models/expense.dart';
import 'providers/expense_provider.dart';

void main() {
  final container = ProviderContainer();
  final expenseListNotifier = container.read(expenseListProvider.notifier);

  while (true) {
    print('\nExpense Tracker');
    print('1. View All Expenses');
    print('2. Add Expense');
    print('3. Update Expense');
    print('4. Delete Expense');
    print('5. View Total Expenses');
    print('6. View Expenses by Category');
    print('7. Exit');
    stdout.write('Choose an option: ');

    final choice = stdin.readLineSync();

    if (choice == null || !['1', '2', '3', '4', '5', '6', '7'].contains(choice)) {
      print('Invalid option. Please enter a number between 1 and 7.');
      continue;
    }

    switch (choice) {
      case '1':
        viewExpenses(container);
        break;
      case '2':
        addExpense(container);
        break;
      case '3':
        updateExpense(container);
        break;
      case '4':
        deleteExpense(container);
        break;
      case '5':
        viewTotalExpenses(container);
        break;
      case '6':
        viewExpensesByCategory(container);
        break;
      case '7':
        print('Exiting...');
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}

void viewExpenses(ProviderContainer container) {
  final expenseList = container.read(expenseListProvider);
  if (expenseList.isEmpty) {
    print('No expenses recorded.');
  } else {
    for (int i = 0; i < expenseList.length; i++) {
      print('$i. ${expenseList[i]}');
    }
  }
}

void addExpense(ProviderContainer container) {
  stdout.write('Enter expense description: ');
  final description = stdin.readLineSync() ?? '';
  
  stdout.write('Enter amount: ');
  final amount = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
  
  stdout.write('Enter category: ');
  final category = stdin.readLineSync() ?? '';

  final newExpense = Expense(
    description: description,
    amount: amount,
    category: category,
    date: DateTime.now(),
  );

  container.read(expenseListProvider.notifier).addExpense(newExpense);
  print('Expense added!');
}

void updateExpense(ProviderContainer container) {
  stdout.write('Enter expense index to update: ');
  final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  final expenses = container.read(expenseListProvider);
  
  if (index >= 0 && index < expenses.length) {
    final currentExpense = expenses[index];
    
    stdout.write('Enter new description (current: ${currentExpense.description}): ');
    final description = stdin.readLineSync() ?? currentExpense.description;
    
    stdout.write('Enter new amount (current: ${currentExpense.amount}): ');
    final amount = double.tryParse(stdin.readLineSync() ?? '') ?? currentExpense.amount;
    
    stdout.write('Enter new category (current: ${currentExpense.category}): ');
    final category = stdin.readLineSync() ?? currentExpense.category;

    final updatedExpense = Expense(
      description: description,
      amount: amount,
      category: category,
      date: currentExpense.date,
    );

    container.read(expenseListProvider.notifier).updateExpense(index, updatedExpense);
    print('Expense updated!');
  } else {
    print('Invalid index.');
  }
}

void deleteExpense(ProviderContainer container) {
  stdout.write('Enter expense index to delete: ');
  final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  
  if (index >= 0 && index < container.read(expenseListProvider).length) {
    container.read(expenseListProvider.notifier).deleteExpense(index);
    print('Expense deleted!');
  } else {
    print('Invalid index.');
  }
}

void viewTotalExpenses(ProviderContainer container) {
  final total = container.read(expenseListProvider.notifier).getTotalExpenses();
  print('\nTotal Expenses: \$${total.toStringAsFixed(2)}');
}

void viewExpensesByCategory(ProviderContainer container) {
  final categoryTotals = container.read(expenseListProvider.notifier).getExpensesByCategory();
  print('\nExpenses by Category:');
  categoryTotals.forEach((category, total) {
    print('$category: \$${total.toStringAsFixed(2)}');
  });
}
