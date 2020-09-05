import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../utils/transactions_db.dart';
import '../../models/transaction.dart';
import './transactions_chart_view_item.dart';

class TransactionChartView extends StatelessWidget {
  final _transactions = TransactionsDB.instance.getData();

  List<Map<String, Object>> get transactionsDataGroupedByDay {
    if (_transactions.isNotEmpty) {
      List<Transaction> lastWeekTransactions = _transactions
          .where((element) =>
              element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
          .toList();

      double lastWeekTotalSum = _transactions.fold(
          0.0, (previousValue, element) => previousValue += element.price);

      DateTime weekDay;
      return List.generate(7, (index) {
        weekDay = DateTime.now().subtract(Duration(days: index));

        double totalSum = 0.0;

        lastWeekTransactions.forEach((element) {
          if (element.date.year == weekDay.year &&
              element.date.month == weekDay.month &&
              element.date.day == weekDay.day) {
            totalSum += element.price;
          }
        });

        return {
          "dayName": weekDay.day.toString(),
          "dayTotalSum": totalSum,
          "daySumProcentFromWeekTotal": totalSum / lastWeekTotalSum,
        };
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(transactionsDataGroupedByDay);
    return transactionsDataGroupedByDay != null
        ? Row(
            children: [
              ...transactionsDataGroupedByDay.map((e) {
                print(e);
                return TransactionsChartViewItem(e);
              }).toList()
            ],
          )
        : Container();
  }
}
