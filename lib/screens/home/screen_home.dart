import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_manager/screens/category/category_add_popup.dart';
import 'package:personal_money_manager/screens/category/screen_category.dart';
import 'package:personal_money_manager/screens/home/widgets/bottom_navigation_bar.dart';
import 'package:personal_money_manager/screens/transaction/screen_add_transactions.dart';
import 'dart:io';

import '../transaction/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});



  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
   ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
     final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            middle: Center(
                child: Text(
              "Buget Friend",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorLight),
            )),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (selectedIndexNotifier.value == 0) {
                      print("transaction page");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenAddTransactions(),
                          ));
                    } else {
                      print("category page");
                      showCategoryAddPopup(context);
                    }
                  },
                  child: Icon(CupertinoIcons.money_dollar),
                ),
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Center(
                child: Text(
              'Budget Friend',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorLight),
            )),
          ) as PreferredSizeWidget;
    return   Platform.isIOS
        ? CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget, child: Container(),

    )
        :Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).primaryColorLight,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print("transaction page");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenAddTransactions(),
                ));
          } else {
            print("category page");
            showCategoryAddPopup(context);
          }
        },
        child:ValueListenableBuilder(valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int value, Widget? child) {
          return selectedIndexNotifier.value==0?Icon(CupertinoIcons.money_dollar):Icon(Icons.category);
    },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: MoneyManagerBottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (context, updatedIndex, _) {
          return _pages[updatedIndex];
        },
      )),
    );
  }
}
