import 'package:riverpod/riverpod.dart';
import '../models/expense.dart';


class ExpenseListNotifier extends StateNotifier<List<Expense>> {
  ExpenseListNotifier() : super([]);

 
  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  
  void updateExpense(int index, Expense expense) {
    if (index >= 0 && index < state.length) {
      final newState = List<Expense>.from(state);
      newState[index] = expense;
      state = newState; 
    }
  }

  
  void deleteExpense(int index) {
    if (index >= 0 && index < state.length) {
      final newState = List<Expense>.from(state);
      newState.removeAt(index);
      state = newState; 
    }
  }

 
  double getTotalExpenses() {
    return state.fold(0, (sum, expense) => sum + expense.amount); 
  }

  
  Map<String, double> getExpensesByCategory() {
    final categoryTotals = <String, double>{};
    for (final expense in state) {
      categoryTotals[expense.category] = (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    return categoryTotals; 
  }
}


final expenseListProvider =
    StateNotifierProvider<ExpenseListNotifier, List<Expense>>((ref) {
  return ExpenseListNotifier();
});
