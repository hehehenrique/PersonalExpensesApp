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
        FittedBox(
          child: Text('\$${_valueAsString}'),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 14,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: fillFactor,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ]),
    );
  }
}
