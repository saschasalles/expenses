import 'package:expenses/models/app_state_model.dart';
import 'package:expenses/widgets/expense_row_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:expenses/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class LandingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final expense = model.getLatestExpenses();
        final amounts = model.getAllAmounts();
        return CustomScrollView(
          semanticChildCount: expense.length,
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Accueil'),
            ),
            SliverToBoxAdapter(
              child: Column(
                  children: <Widget> [
                    SizedBox(height: 18),
                    Text(
                      'Vos dépenses mensuelles',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        height: 140,
                        child: new Sparkline(
                          data: amounts,
                          lineWidth: 5.0,
                          fillMode: FillMode.below,
                          lineGradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [CupertinoColors.systemBlue, CupertinoColors.systemTeal],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Vos dernières dépenses',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ]
              ),
            ),
            SliverSafeArea(
              top: false,
              bottom: false,
              minimum: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < expense.length) {
                      return ExpenseRowItem(
                        index: index,
                        expense: expense[index],
                        lastItem: index == expense.length - 1,
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Voir toutes mes dépenses'),
                      color: CupertinoColors.systemBlue,
                      onPressed: () => globals.tabController.index = 1,
                    ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
