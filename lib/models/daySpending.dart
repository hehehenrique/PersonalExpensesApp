import 'package:flutter/foundation.dart';

class DaySpending {
  final String day;
  final double spending;
  final double
      factorOfTotalSpending; // [0, 1] How much did we spend on this day compared to the rest of time period

  DaySpending(
    this.day,
    this.spending,
    this.factorOfTotalSpending,
  );
}
