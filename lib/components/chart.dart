import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentsTransactions;
  Chart(this.recentsTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentsTransactions.length; i++) {
        bool sameDay = recentsTransactions[i].date.day == weekDay.day;
        bool sameMouth = recentsTransactions[i].date.month == weekDay.month;
        bool sameYear = recentsTransactions[i].date.year == weekDay.year;
        if (sameDay && sameMouth && sameYear) {
          totalSum += recentsTransactions[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0.0, (previousValue, element) => previousValue + element['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Expanded(
              child: ChartBar(
                day: tr['day'],
                value: tr['value'],
                percent: _weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
