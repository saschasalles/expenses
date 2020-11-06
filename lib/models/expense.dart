import 'package:flutter/foundation.dart';

enum ExpCategory {
  Abonnements,
  Alimentation,
  Autres,
  Beaute,
  Carburant,
  Culture,
  Factures,
  Famille,
  Reparations,
  Sante,
  Shopping,
  Sorties,
  Sports,
  Tabac,
}

class Expense {
  const Expense({
      @required this.category,
      @required this.id,
      @required this.description,
      @required this.name,
      @required this.amount,
      @required this.urlLogo})
      : assert(category != null),
        assert(id != null),
        assert(description != null),
        assert(name != null),
        assert(amount != null),
        assert(urlLogo != null);

  final ExpCategory category;
  final int id;
  final String description;
  final String name;
  final double amount;
  final String urlLogo;

  String getName() => name;

  @override
  String toString() => '$name (id=$id)';
}
