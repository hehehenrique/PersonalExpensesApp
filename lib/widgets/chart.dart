import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chartBar.dart';
import '../models/transaction.dart';
import '../models/daySpending.dart';

class Chart extends StatelessWidget {
  Chart(this._recentTransactions);

  final List<Transaction>
      _recentTransactions; // right now we're assuming that these are this week's transactions

  double get _thisWeekTotalSpending {
    return _recentTransactions.fold(0.0, (sum, tx) {
      return sum + tx.amount;
    });
  }

  List<DaySpending> get _groupedThisWeekDaySpendings {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalDaySpending = 0.0;
      for (var transaction in _recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalDaySpending += transaction.amount;
        }
      }

      return DaySpending(
        DateFormat.E().format(weekDay).substring(0, 1),
        totalDaySpending,
        ((_thisWeekTotalSpending == 0.0)
            ? 0.0
            : (totalDaySpending / _thisWeekTotalSpending)),
      );
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: _groupedThisWeekDaySpendings.map((weekDaySpendings) {
            return Expanded(
              child: ChartBar(
                label: weekDaySpendings.day,
                value: weekDaySpendings.spending,
                fillFactor: weekDaySpendings.factorOfTotalSpending,
              ),
            );
          }).toList(),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
