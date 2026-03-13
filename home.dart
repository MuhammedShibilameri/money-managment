// import 'dart:convert';
// import 'package:flutter/material.dart';
// // import 'package:flutter_application_1/income.dart';
// import 'package:flutter_application_1/income_history.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/history.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<Map<String, String>> recentTransactions = [];
//   double totalIncome = 0;
//   double totalExpense = 0;

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();

 
//     List<String> expenseStrings = prefs.getStringList('expenses') ?? [];
//     List<Map<String, String>> allExpenses = expenseStrings
//         .map((e) => Map<String, String>.from(jsonDecode(e)))
//         .toList();
//     for (var exp in allExpenses) {
//       exp['type'] = 'expense';
//     }

    
//     List<String> incomeStrings = prefs.getStringList('incomes') ?? [];
//     List<Map<String, String>> allIncomes = incomeStrings
//         .map((e) => Map<String, String>.from(jsonDecode(e)))
//         .toList();
//     for (var inc in allIncomes) {
//       inc['type'] = 'income';
//     }

 
//     double incomeSum = allIncomes.fold(
//       0,
//       (sum, inc) => sum + (double.tryParse(inc['amount'] ?? '0') ?? 0),
//     );
//     double expenseSum = allExpenses.fold(
//       0,
//       (sum, exp) => sum + (double.tryParse(exp['amount'] ?? '0') ?? 0),
//     );

   
//     List<Map<String, String>> allTransactions = [...allIncomes, ...allExpenses];

    
//     allTransactions.sort((a, b) {

//       final dateA = a['date'] ?? '';
//       final dateB = b['date'] ?? '';
//       return dateB.compareTo(dateA); 
//     });

//     setState(() {
//       totalIncome = incomeSum;
//       totalExpense = expenseSum;
//       recentTransactions = allTransactions.take(5).toList(); 
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double totalBalance = totalIncome - totalExpense;

//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.menu),
//         title: Text(
//           'Money Management',
//           style: TextStyle(
//             fontWeight: FontWeight.w900,
//             color: Color.fromARGB(255, 95, 95, 95),
//           ),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(255, 240, 241, 241),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
       
//               Container(
//                 height: 183,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color.fromARGB(255, 1, 28, 47),
//                       Color(0xFF3C40C6),
//                       Color(0xFF00A8FF),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Total Balance',
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       '   ₹${totalBalance.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 39,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     Spacer(),
//                     Divider(color: Colors.white54),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               '   Income',
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Text(
//                               '  ₹${totalIncome.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Expense  ',
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Text(
//                               '₹${totalExpense.toStringAsFixed(2)}    ',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 20),

//           Row(
//   children: [
//     Expanded(
//       child: ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green, 
//           padding:  EdgeInsets.symmetric(vertical: 16,horizontal: 50),           
//         ),
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => IncomeHistoryPage()),
//           ).then((_) => loadData());
//         },
//         icon:  Icon(Icons.add),
//         label:  Text('Add Income'),
//       ),
//     ),
//     SizedBox(width: 12),
//     Expanded(
//       child: ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red,
//           padding: EdgeInsets.symmetric(vertical: 16,horizontal: 50),    
//         ),
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => HistoryPage()),
//           ).then((_) => loadData());
//         },
//         icon: Icon(Icons.add),
//         label:  Text('Add Expense'),
//       ),
//     ),
//   ],
// ),

//               SizedBox(height: 30),

//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'Recent Transactions',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 95, 95, 95),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Divider(),
//                     if (recentTransactions.isEmpty)
//                       Padding(
//                         padding:  EdgeInsets.all(12.0),
//                         child: Text("No recent transactions"),
//                       )
//                     else
//                       Column(
//                         children: recentTransactions.map((txn) {
//                           bool isIncome = txn['type'] == 'income';
//                           return Column(
//                             children: [
//                               ListTile(
//                                 leading: Icon(
//                                   Icons.attach_money,
//                                   color: isIncome ? Colors.green : Colors.red,
//                                 ),
//                                 title: Text(
//                                   isIncome
//                                       ? (txn['source'] ?? 'Income')
//                                       : (txn['category'] ?? 'Expense'),
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color.fromARGB(255, 117, 116, 116),
//                                   ),
//                                 ),
//                                 subtitle: Text(txn['note'] ?? ''),
//                                 trailing: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       "₹${txn['amount'] ?? ''}",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: isIncome
//                                             ? Colors.green
//                                             : Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       txn['date'] ?? '',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Color.fromARGB(255, 92, 91, 91),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/income_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/history.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> recentTransactions = [];
  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> expenseStrings = prefs.getStringList('expenses') ?? [];
    List<Map<String, String>> allExpenses = expenseStrings
        .map((e) => Map<String, String>.from(jsonDecode(e)))
        .toList();
    for (var exp in allExpenses) {
      exp['type'] = 'expense';
    }

    List<String> incomeStrings = prefs.getStringList('incomes') ?? [];
    List<Map<String, String>> allIncomes = incomeStrings
        .map((e) => Map<String, String>.from(jsonDecode(e)))
        .toList();
    for (var inc in allIncomes) {
      inc['type'] = 'income';
    }

    double incomeSum = allIncomes.fold(
      0,
      (sum, inc) => sum + (double.tryParse(inc['amount'] ?? '0') ?? 0),
    );
    double expenseSum = allExpenses.fold(
      0,
      (sum, exp) => sum + (double.tryParse(exp['amount'] ?? '0') ?? 0),
    );

    List<Map<String, String>> allTransactions = [...allIncomes, ...allExpenses];
    allTransactions.sort((a, b) {
      final dateA = a['date'] ?? '';
      final dateB = b['date'] ?? '';
      return dateB.compareTo(dateA);
    });

    setState(() {
      totalIncome = incomeSum;
      totalExpense = expenseSum;
      recentTransactions = allTransactions.take(5).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalBalance = totalIncome - totalExpense;

    // ✅ Read theme colors from context — automatically responds to dark/light mode
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color scaffoldBg = isDark
        ? const Color(0xFF121212)
        : const Color.fromARGB(255, 240, 241, 241);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark
        ? const Color(0xFFCCCCCC)
        : const Color.fromARGB(255, 95, 95, 95);
    final Color subtitleColor = isDark
        ? const Color(0xFF999999)
        : const Color.fromARGB(255, 117, 116, 116);
    final Color dividerColor =
        isDark ? Colors.grey[800]! : Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text(
          'Money Management',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
      ),
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Balance Card (gradient — looks great in both modes) ──
              Container(
                height: 183,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 1, 28, 47),
                      Color(0xFF3C40C6),
                      Color(0xFF00A8FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Balance',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '   ₹${totalBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 39,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    const Divider(color: Colors.white54),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '   Income',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 14),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '  ₹${totalIncome.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Expense  ',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 14),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '₹${totalExpense.toStringAsFixed(2)}    ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Action Buttons ──
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => IncomeHistoryPage()))
                            .then((_) => loadData());
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Income'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => ExpenseHistoryPage()))
                            .then((_) => loadData());
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Expense'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ── Recent Transactions Card ──
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cardBg, // ✅ Dark-aware card background
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Recent Transactions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor, // ✅ Dark-aware
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: dividerColor), // ✅ Dark-aware divider
                    if (recentTransactions.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "No recent transactions",
                          style: TextStyle(color: subtitleColor),
                        ),
                      )
                    else
                      Column(
                        children: recentTransactions.map((txn) {
                          bool isIncome = txn['type'] == 'income';
                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.attach_money,
                                  color:
                                      isIncome ? Colors.green : Colors.red,
                                ),
                                title: Text(
                                  isIncome
                                      ? (txn['source'] ?? 'Income')
                                      : (txn['category'] ?? 'Expense'),
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: subtitleColor, // ✅ Dark-aware
                                  ),
                                ),
                                subtitle: Text(
                                  txn['note'] ?? '',
                                  style: TextStyle(color: subtitleColor),
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "₹${txn['amount'] ?? ''}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isIncome
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      txn['date'] ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: subtitleColor, // ✅ Dark-aware
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: dividerColor), // ✅ Dark-aware
                            ],
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } 
}