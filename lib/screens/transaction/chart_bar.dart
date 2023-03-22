import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;
  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPercent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constriants) {
        return Column(
          children: [
            SizedBox(
              height: constriants.maxHeight * 0.04,
            ),
            Container(
              height: constriants.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
            SizedBox(
              height: constriants.maxHeight * 0.05,
            ),
            Container(
              height: constriants.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                          width: 1.0),
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercent,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark),
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constriants.maxHeight * 0.05,
            ),
            Container(
              height: constriants.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
