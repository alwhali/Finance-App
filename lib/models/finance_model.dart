import 'package:hive/hive.dart';

part 'finance_model.g.dart';

@HiveType(typeId: 0)
class FinanceModel {
  @HiveField(0)
  String details;

  @HiveField(1)
  double financeValue;

  @HiveField(2)
  DateTime dateTime;

  FinanceModel({
    required this.details,
    required this.financeValue,
    required this.dateTime,
  });
}
