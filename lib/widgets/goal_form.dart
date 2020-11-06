import 'package:expenses/models/expense.dart';
import 'package:expenses/models/goal.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:expenses/models/app_state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/globals.dart' as globals;

class GoalForm extends StatefulWidget {
  @override
  _GoalFormState createState() {
    return _GoalFormState();
  }
}

class _GoalFormState extends State<GoalForm> {
  String name;
  double maxAmount;
  ExpCategory category;
  int selection = 0;

  Widget _buildTitleField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.pencil,
        color: CupertinoColors.systemGrey,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      placeholder: 'Titre',
      placeholderStyle: TextStyle(color: CupertinoColors.systemGrey),
      onChanged: (newName) {
        setState(() {
          name = newName;
        });
      },
    );
  }

  Widget _buildAmountField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.money_euro,
        color: CupertinoColors.systemGrey,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      placeholder: 'Montant',
      placeholderStyle: TextStyle(color: CupertinoColors.systemGrey),
      onChanged: (newAmount) {
        setState(() {
          maxAmount = double.parse(newAmount);
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return Container(
            child: Column(children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Catégorie",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    height: 130,
                    child: CupertinoPicker(
                        useMagnifier: true,
                        onSelectedItemChanged: (value) {
                          selection = value;
                        },
                        itemExtent: 32.0,
                        children: ExpCategory.values
                            .map((c) => Text(c
                                .toString()
                                .substring(c.toString().indexOf('.') + 1)))
                            .toList())),
              ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: _buildTitleField(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: _buildAmountField(),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CupertinoButton(
              color: CupertinoColors.systemBlue,
              child: Text("Ajouter"),
              onPressed: () {
                bool error = false;
                // to do checks
                if (!error) {
                final model = Provider.of<AppStateModel>(context, listen: false);
                  var goal = new Goal(
                      category: ExpCategory.values[selection],
                      id: model.getGoals().length + 1,
                      name: this.name,
                      maxAmount: this.maxAmount,
                      );
                  model.setGoals(goal);
                  Navigator.of(context).pop();
                  globals.tabController.index = 2;
                }
              },
            ),
          )
        ]));
      },
    );
  }
}
