import 'package:flutter/foundation.dart';
import 'package:expenses/models/expense.dart';

class Goal {
  const Goal(
      {@required this.category,
      @required this.id,
      @required this.name,
      @required this.maxAmount})
      : assert(category != null),
        assert(id != null),
        assert(name != null),
        assert(maxAmount != null);

  final ExpCategory category;
  final int id;
  final String name;
  final double maxAmount;

  String getName() => name;

  @override
  String toString() => '$name (id=$id)';
}
