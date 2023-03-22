import 'package:flutter/material.dart';
import 'package:personal_money_manager/db/category/category_db.dart';
import 'package:personal_money_manager/screens/category/expense_list.dart';
import 'package:personal_money_manager/screens/category/income_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  @override
  void initState(){
    CategoryDB().refreshUI();
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(


      length: 2,
      child: Column(

         children: [
           TabBar(

             labelColor: Theme.of(context).primaryColorDark,
               unselectedLabelColor: Colors.grey[600],
               tabs: [
             Tab(text: 'INCOME',),
             Tab(text: 'EXPENSE',),
           ]),
           Expanded(
             child: TabBarView(children: [
               IncomeCategoryList(),
               ExpenseCategoryList(),

             ]),
           )

         ],
      ),
    );
  }
}
