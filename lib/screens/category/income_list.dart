import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../db/category/category_db.dart';
import '../../db/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().incomeCategoryListListner, builder: (BuildContext context, List<CategoryModel> newlist, Widget?_) {
      return ListView.separated(itemBuilder: (context, index) {
        final category=newlist[index];
        return Slidable(
          startActionPane: ActionPane(motion: BehindMotion(), children: [
            SlidableAction(
              backgroundColor: Theme.of(context).primaryColorLight,
              onPressed: (context) {
                CategoryDB.instance.deleteCategory(category.id);
              },icon: Icons.delete,label: "Delete",)
          ]),
          child: Card(
            color: Theme.of(context).primaryColorLight,
            elevation: 10,
            child: ListTile(

              title: Text(category.name),

            ),
          ),
        );
      }, separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: newlist.length);
    },);
  }
}
