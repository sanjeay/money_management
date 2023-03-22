import 'package:flutter/material.dart';
import 'package:personal_money_manager/db/category/category_db.dart';
import 'package:personal_money_manager/db/transaction/transaction_db.dart';
import 'package:personal_money_manager/models/category/category_model.dart';
import 'package:personal_money_manager/models/transactions/transaction_model.dart';

class ScreenAddTransactions extends StatefulWidget {
  const ScreenAddTransactions({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransactions> createState() => _ScreenAddTransactionsState();
}

class _ScreenAddTransactionsState extends State<ScreenAddTransactions> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _dropdownValue;
  final _purposeTextEditingController = TextEditingController();

  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {

    _selectedCategoryType = CategoryType.income;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _purposeTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "Purpose"),
                ),
                TextFormField(
                  controller: _amountTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Amount"),
                ),
                TextButton.icon(
                    onPressed: () async {
                      final _selectedDateTemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(Duration(days: 30)),
                          lastDate: DateTime.now());
                      if (_selectedDateTemp == null) {
                        return;
                      } else {
                        print(_selectedDateTemp.toString());
                        setState(() {
                          _selectedDate = _selectedDateTemp;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(_selectedDate == null
                        ? "Select Date"
                        : _selectedDate.toString())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = newValue;
                          _dropdownValue = null;
                        });
                      },
                    ),
                    Text("Income"),
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = newValue;
                          _dropdownValue = null;
                        });
                      },
                    ),
                    Text("Expense")
                  ],
                ),
                DropdownButton(
                  hint: Text("Select Category"),
                  value: _dropdownValue,
                  items: (_selectedCategoryType == CategoryType.income
                          ? CategoryDB.instance.incomeCategoryListListner
                          : CategoryDB.instance.expenseCategoryListListner)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      _dropdownValue = selectedValue;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      addTransaction();

                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_dropdownValue == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    //_selectedDate
    //_selectedCategoryType
    final _model=TransactionModel(
        purpose: _purposeText,
        date: _selectedDate!,
        amount: _parsedAmount,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!);

    await TransactionDB.instancs.addTransaction(_model);
    Navigator.pop(context);

  }
}
