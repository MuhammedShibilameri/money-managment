import 'package:hive/hive.dart';

class HiveService {

  static final box = Hive.box('expenseBox');

 
  static void addExpense(Map<String, dynamic> expense) {
    List expenses = box.get('expenses', defaultValue: []);

    expenses.add(expense);

    box.put('expenses', expenses);
  }


  static List getExpenses() {
    return box.get('expenses', defaultValue: []);
  }


  static void deleteExpense(int index) {
    List expenses = box.get('expenses', defaultValue: []);

    expenses.removeAt(index);

    box.put('expenses', expenses);
  }

  
  static void clearExpenses() {
    box.put('expenses', []);
  }
} 