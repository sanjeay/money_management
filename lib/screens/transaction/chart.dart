import 'dart:core';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_manager/models/transactions/transaction_model.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> recentTransactions;

  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(15),
      elevation: 20,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: e['day'].toString(),
                    spendingAmount: double.parse(e['amount'].toString()),
                    spendingPercent: totalSpending == 0.0
                        ? 0.0
                        : (e['amount'] as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }
}

