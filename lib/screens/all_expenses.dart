import 'package:expenses/screens/add_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:expenses/widgets/expense_row_item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:expenses/models/app_state_model.dart';


class AllExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final expense = model.getReversedExpenses();
        return CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Mes dépenses'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              sliver: 
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < expense.length) {
                        return GestureDetector(
                          onLongPress: () => 
                            showCupertinoModalPopup(
                              context: context, 
                              builder: (context) => 
                                CupertinoActionSheet(
                                  title: Text("Supprimer une dépense"),
                                  actions: [
                                    // CupertinoActionSheetAction(
                                    //   onPressed: () => AddExpenseScreen(), 
                                    //   child: Text("Modifier")),
                                    CupertinoActionSheetAction(
                                      onPressed: () => { 
                                        model.removeExpense(expense[index]), 
                                        Navigator.pop(context, 'Cancel'),
                                        },
                                      child: Text("Supprimer")),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                      onPressed: () => Navigator.pop(context, 'Cancel'), 
                                      child: Text("Annuler"),
                                      isDefaultAction: true,
                                      ),
                                ),
                            ),
                          child:                             
                            ExpenseRowItem(
                                index: index,
                                expense: expense[index],
                                lastItem: index == expense.length - 1,
                              ) 
                        );
                      }
                      return null;
                    },
                  ),
                )
            )
          ],
        );
      },
    );
  }
}
