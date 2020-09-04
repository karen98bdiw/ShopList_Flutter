import 'package:shop_list_v2/models/transaction.dart';

class TransactionsDB {
  final List<Transaction> _data = [];
  //cant create new instance ,constuctor is private
  TransactionsDB._privateConstructor();

  static final TransactionsDB instance = TransactionsDB._privateConstructor();
  //al time when will try to make db will get reference to single instance
  factory TransactionsDB() {
    return instance;
  }

  void addData(Transaction tr) {
    _data.add(tr);
  }

  void deleteData(Transaction tr) {
    _data.remove(tr);
  }

  void deleteById(String id) {
    _data.removeWhere((element) => element.id == id);
  }

  List<Transaction> getData() {
    return _data;
  }
}
