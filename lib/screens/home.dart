import 'package:expenses/screens/add.dart';
import 'package:expenses/screens/all_expenses.dart';
import 'package:expenses/screens/goals.dart';
import 'package:flutter/cupertino.dart';
import 'package:expenses/screens/landing.dart';
import 'package:expenses/globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CupertinoTabController _tabController;

  @override
  void initState() {
    _tabController = CupertinoTabController(initialIndex: 0);
    globals.tabController = _tabController;
    super.initState();
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_euro),
            label: 'Mes dépenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.check_mark),
            label: 'Objectifs',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus),
            label: 'Ajouter',
          ),
        ],
      ),
      controller: _tabController,
      tabBuilder: (BuildContext context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: LandingScreen(),
                ),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: AllExpensesScreen(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: GoalsScreen(),
              );
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: AddScreen(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
