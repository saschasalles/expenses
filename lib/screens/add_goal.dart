import 'package:expenses/widgets/goal_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:expenses/models/goal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

// expenseModel.getExpenses[0].price.toString()
//AddButton("assets/images/finance_graph.png", "Nouvelle Dépense")
class AddGoalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return CupertinoScaffold(
      transitionBackgroundColor: CupertinoColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Container(
          color: CupertinoColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nouvel Objectif',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Remplissez le formulaire ci-dessous',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: CupertinoColors.systemGrey
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),),
              Image.asset("assets/images/goals.png",
              fit: BoxFit.cover),
              GoalForm(),
            ],
          ),
        ),
      ),
    );
  }
}