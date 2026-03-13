

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AddExpensePage extends StatefulWidget {
//   final Map<String, String>? existingExpense;

//   const AddExpensePage({super.key, this.existingExpense});

//   @override
//   _AddExpensePageState createState() => _AddExpensePageState();
// }

// class _AddExpensePageState extends State<AddExpensePage> {
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController noteController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   String selectedCategory = "Food";

//   @override
//   void initState() {
//     super.initState();
//     if (widget.existingExpense != null) {
//       amountController.text = widget.existingExpense!['amount'] ?? '';
//       noteController.text = widget.existingExpense!['note'] ?? '';
//       dateController.text = widget.existingExpense!['date'] ?? '';
//       selectedCategory = widget.existingExpense!['category'] ?? 'Food';
//     }
//   }

//   Future<void> saveExpense(Map<String, String> expense, {bool isEdit = false}) async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> expenseStrings = prefs.getStringList('expenses') ?? [];
//     List<Map<String, String>> allExpenses =
//         expenseStrings.map((e) => Map<String, String>.from(jsonDecode(e))).toList();

//     if (isEdit && widget.existingExpense != null) {
//       int index = allExpenses.indexWhere(
//         (e) =>
//             e['amount'] == widget.existingExpense!['amount'] &&
//             e['note'] == widget.existingExpense!['note'] &&
//             e['date'] == widget.existingExpense!['date'] &&
//             e['category'] == widget.existingExpense!['category'],
//       );
//       if (index != -1) {
//         allExpenses[index] = expense;
//       }
//     } else {
//       allExpenses.add(expense);
//     }

//     await prefs.setStringList(
//       'expenses',
//       allExpenses.map((e) => jsonEncode(e)).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditing = widget.existingExpense != null;

//     return Scaffold(
//       appBar: AppBar(title: Text(isEditing ? "Edit Expense" : "Add Expense")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildInputContainer(
//               child: TextField(
//                 controller: amountController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: "Amount",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildInputContainer(
//               child: DropdownButtonFormField<String>(
//                 value: selectedCategory,
//                 items: ["Food", "Travel", "Bills", "Shopping", "Others"]
//                     .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCategory = value!;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   labelText: "Category",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildInputContainer(
//               child: TextField(
//                 controller: noteController,
//                 decoration: const InputDecoration(
//                   labelText: "Note",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildInputContainer(
//               child: TextField(
//                 controller: dateController,
//                 decoration: const InputDecoration(
//                   labelText: "Date",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final expense = {
//                   'amount': amountController.text,
//                   'category': selectedCategory,
//                   'note': noteController.text,
//                   'date': dateController.text,
//                   'type': 'expense',
//                 };
//                 await saveExpense(expense, isEdit: isEditing);
//                 Navigator.pop(context, expense);
//               },
//               child: Text(isEditing ? "Save Changes" : "Add Expense"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputContainer({required Widget child}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 255, 255), 
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       child: child,
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpensePage extends StatefulWidget {
  final Map<String, String>? existingExpense;

  const AddExpensePage({super.key, this.existingExpense});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String selectedCategory = "Food";

  @override
  void initState() {
    super.initState();
    if (widget.existingExpense != null) {
      amountController.text = widget.existingExpense!['amount'] ?? '';
      noteController.text = widget.existingExpense!['note'] ?? '';
      dateController.text = widget.existingExpense!['date'] ?? '';
      selectedCategory = widget.existingExpense!['category'] ?? 'Food';
    }
  }

  Future<void> saveExpense(Map<String, String> expense, {bool isEdit = false}) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> expenseStrings = prefs.getStringList('expenses') ?? [];
    List<Map<String, String>> allExpenses =
        expenseStrings.map((e) => Map<String, String>.from(jsonDecode(e))).toList();

    if (isEdit && widget.existingExpense != null) {
      int index = allExpenses.indexWhere((e) =>
          e['amount'] == widget.existingExpense!['amount'] &&
          e['note'] == widget.existingExpense!['note'] &&
          e['date'] == widget.existingExpense!['date'] &&
          e['category'] == widget.existingExpense!['category']);
      if (index != -1) {
        allExpenses[index] = expense;
      }
    } else {
      allExpenses.add(expense);
    }

    await prefs.setStringList(
      'expenses',
      allExpenses.map((e) => jsonEncode(e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingExpense != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Expense" : "Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputContainer(
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildInputContainer(
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                items: ["Food", "Travel", "Bills", "Shopping", "Others"]
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildInputContainer(
              child: TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: "Note",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildInputContainer(
              child: TextField(
                controller: dateController,
                readOnly: true, 
                decoration: InputDecoration(
                  labelText: "Date",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100), 
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final expense = {
                  'amount': amountController.text,
                  'category': selectedCategory,
                  'note': noteController.text,
                  'date': dateController.text,
                  'type': 'expense',
                };
                await saveExpense(expense, isEdit: isEditing);
                Navigator.pop(context, expense);
              },
              child: Text(isEditing ? "Save Changes" : "Add Expense"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputContainer({required Widget child}) { 
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(77, 241, 240, 240),
        borderRadius: BorderRadius.circular(8), 
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: child,
    );
  }
}  