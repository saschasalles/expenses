import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/widgets/goal_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:expenses/models/app_state_model.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/models/goal.dart';

class GoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final goals = model.getGoals();
        var listTotalAmounts = [];
        for (var i = 0; i < goals.length; i++) {
          var amounts = [];
          var expenses = model.getExpenseByCategory(goals[i].category.index);
          if (expenses.length < 1) {
            listTotalAmounts.add(0);
            continue;
          }
          expenses.forEach((exp) {
            amounts.add(exp.amount);
          });
          var sum = amounts.reduce((a, b) => a + b);
          listTotalAmounts.add(sum);
        }

        return CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Objectifs'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < goals.length) {
                      return GestureDetector(
                        onLongPress: () => showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: Text("Supprimer un objectif"),
                                actions: [
                                  // CupertinoActionSheetAction(
                                  //   onPressed: () => AddExpenseScreen(),
                                  //   child: Text("Modifier")),
                                  CupertinoActionSheetAction(
                                      onPressed: () => {
                                            model.removeGoal(
                                                goals[index]),
                                            Navigator.pop(context, 'Cancel'),
                                          },
                                      child: Text("Supprimer")),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text("Annuler"),
                                  isDefaultAction: true,
                                ),
                              ),
                            ),
                        child: GoalRowItem(
                          index: index,
                          title: goals[index].name,
                          amount: goals[index].maxAmount,
                          percentage: listTotalAmounts[index] /
                              goals[index].maxAmount,
                          category:
                              goals[index].category.toString().split('.')[1],
                        )
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
