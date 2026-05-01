part of 'add_data_cubit_cubit.dart';

@immutable
sealed class AddDataState {}

final class AddDataCubitInitial extends AddDataState {}

final class AddDataCubitLoading extends AddDataState {}

final class AddDataCubitSuccess extends AddDataState {}

final class AddDataCubitError extends AddDataState {
  final String errorMessage;
  AddDataCubitError(this.errorMessage);
}
