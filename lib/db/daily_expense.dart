import 'package:realm/realm.dart';
part 'daily_expense.g.dart';

@RealmModel() // define a data model class named `_Car`.
class $DailyExpense {
  @PrimaryKey()
  late ObjectId id;

  late int amount;

  late String name;

  late String createDate;
}
