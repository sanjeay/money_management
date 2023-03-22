

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_manager/db/transaction/transaction_db.dart';
import 'package:personal_money_manager/models/transactions/transaction_model.dart';
import 'package:personal_money_manager/screens/transaction/transaction_list_widget.dart';
import '../../db/category/category_db.dart';
import 'chart.dart';
class ScreenTransaction extends StatefulWidget {



   ScreenTransaction( {super.key,});

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction> {

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    TransactionDB.instancs.refresh();
    CategoryDB.instance.refreshUI();
    final transactionList=Container(
      height: mediaQuery.size.height*0.7,
      child: TransactionListWidget(),
    );
    final pageBody= SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          if (isLandscape)
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Show Chart"),
        Switch.adaptive(
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    ),
    if (!isLandscape)
        ValueListenableBuilder<List<TransactionModel>>(
    valueListenable: TransactionDB.instancs.transactionListNotifier,
    builder: (context, transactionList, _) {
// Create a list of recent transactions that is no more than 7 days old
    final List<TransactionModel> recentTransactions = transactionList.where((transaction) {
    final DateTime now = DateTime.now();
    final DateTime transactionDate = DateTime.parse(transaction.date.toString());
    final Duration difference = now.difference(transactionDate);
    return difference.inDays < 7;
    }).toList();

// Build the chart
    return Container(
    height: mediaQuery.size.height*0.21,
    child: Chart(recentTransactions: recentTransactions));
    },
    ),
    if (!isLandscape) transactionList,
    if (isLandscape)
    _showChart?  ValueListenableBuilder<List<TransactionModel>>(
    valueListenable: TransactionDB.instancs.transactionListNotifier,
    builder: (context, transactionList, _) {
// Create a list of recent transactions that is no more than 7 days old
    final List<TransactionModel> recentTransactions = transactionList.where((transaction) {
    final DateTime now = DateTime.now();
    final DateTime transactionDate = DateTime.parse(transaction.date.toString());
    final Duration difference = now.difference(transactionDate);
    return difference.inDays < 7;
    }).toList();

// Build the chart
    return Container(
    height: mediaQuery.size.height*0.6,
    child: Chart(recentTransactions: recentTransactions));
    },
    ):transactionList,
    ]
      ));
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: pageBody);


  }
}
