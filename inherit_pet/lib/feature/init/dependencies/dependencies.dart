import 'package:inherit_pet/feature/money/bloc/money_bloc/money_bloc.dart';
import 'package:inherit_pet/feature/money/money_data_source/money_data_source.dart';

class Dependencies {

  final MoneyDataSource moneyDataSource;

  Dependencies({required this.moneyDataSource});
}