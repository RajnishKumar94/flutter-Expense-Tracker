import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker_app/widgets/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense>  _registeredExpenses=[
    Expense(
      title: 'flutter Course ' ,
      amount: 19.9,
      date: DateTime.now(),
      category: Category.work,


    ),
      Expense(
      title: 'Cinema ' ,
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
      ),
    



  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>  NewExpenses(onAddExpense:  _addExpense,),
    );
  }
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
 void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
      Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ), 
        ],


      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
             child:mainContent,


          ),
        ],
      ),
    );
  }
}
