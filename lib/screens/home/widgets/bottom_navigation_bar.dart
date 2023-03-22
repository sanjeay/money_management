import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:personal_money_manager/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColorDark,

          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Theme.of(context).primaryColorLight,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar), label: "Transactions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Categories"),
          ],
        );
      },
    );
  }
}
