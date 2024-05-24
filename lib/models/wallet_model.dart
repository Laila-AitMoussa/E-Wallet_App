import 'package:hive/hive.dart';
part 'wallet_model.g.dart';

@HiveType(typeId: 1)
class WalletModel extends HiveObject{
  @HiveField(0)
  String details;
  @HiveField(1)
  double value;
  @HiveField(2)
  DateTime date;

  WalletModel({required this.details, required this.value, required this.date});
}
