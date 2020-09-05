import "package:flutter/material.dart";

class TransactionsChartViewItem extends StatelessWidget {
  final Map<String, Object> _transactionsDataForDay;

  TransactionsChartViewItem(this._transactionsDataForDay) {
    print("called");
    print(_transactionsDataForDay);
  }

  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
              "\$${(_transactionsDataForDay["dayTotalSum"] as double).toStringAsFixed(0)}"),
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                  color: Colors.grey[200],
                ),
              ),
              FractionallySizedBox(
                heightFactor:
                    _transactionsDataForDay["daySumProcentFromWeekTotal"],
                child: Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                )),
              ),
            ],
          ),
        ),
        FittedBox(
          child: Text("${_transactionsDataForDay["dayName"]}"),
        )
      ],
    ));
  }
}
