import 'package:expenses/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:expenses/models/app_state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/globals.dart' as globals;

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() {
    return _ExpenseFormState();
  }
}

class _ExpenseFormState extends State<ExpenseForm> {
  String title;
  double amount;
  String urlLogo;
  String description;
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
          title = newName;
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
          amount = double.parse(newAmount);
        });
      },
    );
  }

  Widget _buildUrlLogoField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.bag,
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
      placeholder: 'Enseigne',
      placeholderStyle: TextStyle(color: CupertinoColors.systemGrey),
      onChanged: (newUrl) {
        setState(() {
          urlLogo = newUrl;
        });
      },
    );
  }

  Widget _buildDescriptionField() {
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
      placeholder: 'Description',
      placeholderStyle: TextStyle(color: CupertinoColors.systemGrey),
      onChanged: (newDesc) {
        setState(() {
          description = newDesc;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference expense =
        FirebaseFirestore.instance.collection('expense');

    Future<void> addExpense() {
      // Call the user's CollectionReference to add a new user
      return expense
          .add({
            'amount': amount, // John Doe
            'urlLogo': urlLogo, // Stokes and Sons
            'description': description // 42
          })
          .then((value) => print("Added expenses"))
          .catchError((error) => print("Failed to add user: $error"));
    }

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
            child: _buildDescriptionField(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: _buildUrlLogoField(),
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
                  var convertedString = this.urlLogo.replaceAll(' ', '');
                  var urlLogo =
                      "https://logo.clearbit.com/${convertedString.toLowerCase()}.com";
                  var expense = new Expense(
                      category: ExpCategory.values[selection],
                      id: model.getExpenses().length + 1,
                      description: this.description,
                      name: this.title,
                      amount: this.amount,
                      urlLogo: urlLogo);
                  addExpense();
                  model.setExpenses(expense);
                  Navigator.of(context).pop();
                  globals.tabController.index = 1;
                }
              },
            ),
          )
        ]));
      },
    );
  }
}
