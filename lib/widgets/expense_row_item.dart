import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:expenses/models/app_state_model.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/styles.dart';

class ExpenseRowItem extends StatelessWidget {
  const ExpenseRowItem({
    this.index,
    this.expense,
    this.lastItem,
  });

  final Expense expense;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 8,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image(
              image: NetworkImage(expense.urlLogo),
              height: 60.0,
              width: 60.0,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    expense.name,
                    style: Styles.expenseRowItemName,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    '${expense.category.toString().substring(expense.category.toString().indexOf('.') + 1)}',
                    style: Styles.expenseRowItemPrice,
                  )
                ],
              ),
            ),
          ),
          Text(
            '${expense.amount} €',
            style: Styles.expenseRowItemPrice,
          )
        ],
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.expenseRowDivider,
          ),
        ),
      ],
    );
  }
}