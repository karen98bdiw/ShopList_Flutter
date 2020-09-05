import 'package:flutter/material.dart';
import 'package:shop_list_v2/utils/transactions_db.dart';

class TransactionsListView extends StatelessWidget {
  final Function _dataChengeHandler;

  TransactionsListView(this._dataChengeHandler);

  final _transactions = TransactionsDB.instance.getData();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 40,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      "\$${_transactions[index].price}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            title: Text(
              _transactions[index].title,
            ),
            subtitle: Text(
              _transactions[index].date.toString(),
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  TransactionsDB.instance.deleteData(_transactions[index]);
                  _dataChengeHandler();
                }),
          ),
        );
      },
      itemCount: _transactions.length,
    );
  }
}
