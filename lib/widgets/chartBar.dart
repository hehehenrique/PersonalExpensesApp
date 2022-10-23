import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double fillFactor;

  String get _valueAsString {
    if (value == 0.0) {
      return '0';
    }
    if (value >= 1000000.0) {
      return '${(value / 1000000.0).toStringAsFixed(1)}M';
    }
    if (value >= 1000.0) {
      if (value >= 100000.0) {
        return '${(value / 1000.0).toStringAsFixed(0)}K';
      } else {
        return '${(value / 1000.0).toStringAsFixed(1)}K';
      }
    }
    if (value >= 100.0) {
      return value.toStringAsFixed(0);
    } else {
      return value.toStringAsFixed(2);
    }
  }

  ChartBar({
    @required this.label,
    @required this.value,
    @required this.fillFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text('\$${_valueAsString}',
                style: Theme.of(context).textTheme.titleSmall),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 14,
          child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 3.0,
                ),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
              child: FractionallySizedBox(
                heightFactor: fillFactor,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ]),
        ),
        SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.titleMedium),
      ]),
    );
  }
}
