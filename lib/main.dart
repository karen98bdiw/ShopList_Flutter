import 'package:flutter/material.dart';
import 'package:shop_list_v2/utils/transactions_db.dart';
import './widgets/new_transationc_adding_form.dart';

import './widgets/ChartViewWidgets/transactions_chart_view.dart';
import './widgets/TransactionListViewWidgets/transactions_list_view.dart';

main() => runApp(_App());

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: _AppHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.red,
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )));
  }
}

class _AppHomePage extends StatefulWidget {
  @override
  __AppHomePageState createState() => __AppHomePageState();
}

class __AppHomePageState extends State<_AppHomePage> {
  var isDataChenged = false;

  void _subscribeToDataChange() {
    setState(() {
      isDataChenged = !isDataChenged;
    });
  }

  _startAdding(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactionAddingForm(_subscribeToDataChange),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _HomePageBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAdding(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("ShopList"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print(TransactionsDB.instance.getData().length.toString());
          },
        )
      ],
    );
  }
}

class _HomePageBody extends StatefulWidget {
  @override
  __HomePageBodyState createState() => __HomePageBodyState();
}

class __HomePageBodyState extends State<_HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TransactionChartView(),
          Container(
              height: MediaQuery.of(context).size.height * 1,
              child: TransactionsListView()),
        ],
      ),
    );
  }
}
