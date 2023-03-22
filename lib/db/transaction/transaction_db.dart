import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_manager/models/transactions/transaction_model.dart';



const TRANSACTION_DB_NAME="transaction_db";


abstract class TransactionDbFunctions{
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTransactions();
  Future<void> deleteCategory(String transactionID);
}
class TransactionDB implements TransactionDbFunctions{
  TransactionDB._internal();
  static TransactionDB instancs=TransactionDB._internal();
  factory TransactionDB(){
    return instancs;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifier=ValueNotifier([]);


  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _transactionDB= await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.put(obj.id,obj);
    await refresh();

  }
  Future<void> refresh()async{
    final _list=await getTransactions();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();

  }

  @override
  Future<List<TransactionModel>> getTransactions() async{
    final _transactionDB= await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values .toList();

  }

  @override
  Future<void> deleteCategory(String transactionID) async {
    final _transactionDB= await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.delete(transactionID);
     return await refresh();
  }
  
}