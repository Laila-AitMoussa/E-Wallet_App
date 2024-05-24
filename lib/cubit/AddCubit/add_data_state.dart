part of 'add_data_cubit.dart';

@immutable
sealed class AddDataState {}

final class AddDataInitial extends AddDataState {}

final class AddDataLoading extends AddDataState {}

final class AddDataSuccess extends AddDataState {}

final class AddDataFailure extends AddDataState {
  final String error;
  AddDataFailure(this.error);
}
