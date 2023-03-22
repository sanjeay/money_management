import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../db/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instancs.transactionListNotifier,
      builder: (BuildContext context, value, Widget? _) {
        return ListView.separated(
            physics: ScrollPhysics(),


            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final transaction = value[index];

              return Slidable(

                startActionPane: ActionPane(

                    motion: BehindMotion(), children: [
                  SlidableAction(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    onPressed: (context) {
                    TransactionDB.instancs.deleteCategory(transaction.id!);
                  },icon: Icons.delete,label: "Delete",)
                ]),
                key: Key(transaction.id!),
                child: Card(
                  elevation: 10,
                  color: Theme.of(context).primaryColorLight,

                  child: ListTile(
                    leading: Card(
                      elevation: 10,
                      color: Theme.of(context).primaryColorLight,
                      child: Container(
                          height: 80,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                  Theme.of(context).primaryColorLight)),
                          child: Center(
                              child: Text(
                                '\$${transaction.amount}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              ))),
                    ),
                    title: Text("${transaction.purpose}",style: TextStyle(
                      color: Theme.of(context).primaryColorDark
                    ),),
                    subtitle: Text(DateFormat.yMMMMEEEEd().format(transaction.date),style: TextStyle(
                      color: Theme.of(context).primaryColorDark
                    ),),
                    trailing: transaction.type == CategoryType.income?Icon(Icons.arrow_downward,color: Colors.green,):Icon(Icons.arrow_upward,color: Colors.red,)

                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: value.length);
      },
    );
  }
  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    return _date;
    //return '${date.day}\n${date.month}';
  }
}
