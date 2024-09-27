part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}

class GetInitialExpenseEvent extends ExpenseEvent{}
