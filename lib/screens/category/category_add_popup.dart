import 'package:flutter/material.dart';
import 'package:personal_money_manager/db/category/category_db.dart';

import '../../models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController=TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Category Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RadioButton(title: "Income", type: CategoryType.income),
                RadioButton(title: "Expense", type: CategoryType.expense)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {
              final _name=_nameEditingController.text;
              if(_name.isEmpty){
                return;
              }
                final _type=selectedCategoryNotifier.value;
                final _category=CategoryModel(id: DateTime.now().microsecondsSinceEpoch.toString(), name: _name, type: _type);
                CategoryDB.instance.insertCategory(_category);
                Navigator.of(context).pop();
            }, child: Text("Add")),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;



  RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (context, newCategory, child) => Radio<CategoryType>(
            value: type,
            groupValue: newCategory,
            onChanged: (value) {
              if (value == null) {
                return;
              }
              selectedCategoryNotifier.value = value;
              selectedCategoryNotifier.notifyListeners();
            },
          ),
        ),
        Text(title),
      ],
    );
  }
}
