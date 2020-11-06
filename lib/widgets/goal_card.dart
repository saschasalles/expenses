import 'package:expenses/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses/models/app_state_model.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/styles.dart';

class GoalRowItem extends StatelessWidget {
  const GoalRowItem({
    this.index,
    this.title,
    this.amount,
    this.percentage,
    this.category,
  });

  final int index;
  final String title;
  final double amount;
  final double percentage;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.8,
            color: CupertinoColors.systemGrey5,
          ),
        ),
      ),
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
      margin: EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Styles.expenseRowItemName,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  ProgressBar(progress: percentage),
                  SizedBox(
                    width: 30.0,
                  ),
                  percentage > 1
                      ? Text(
                          'Dépassé',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.0),
                        )
                      : Text(
                          '${(percentage * 100).toStringAsFixed(2)} %',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        )
                ],
              ),
            ),
            Text(
              '${category} • ${amount} €',
              style: Styles.expenseRowItemPrice,
            ),
          ],
        ),
      ),
    );
  }
}
