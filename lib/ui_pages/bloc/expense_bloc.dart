import 'package:bloc/bloc.dart';
import 'package:expense_app/data/models/expense_model.dart';
import 'package:meta/meta.dart';

import '../../data/local/db_helper.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DBHelper dbHelper;

  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());


      bool check = await dbHelper.addExpense(event.newExpense);

      if(check){
        var mData = await dbHelper.getAllExpenses();
        emit(ExpenseLoadedState(mExp: mData));
      } else {
        emit(ExpenseErrorState(errorMsg: "Error: Expense not added!!"));
      }

    });

    on<GetInitialExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      var mData = await dbHelper.getAllExpenses();
      emit(ExpenseLoadedState(mExp: mData));
    });
  }
}
