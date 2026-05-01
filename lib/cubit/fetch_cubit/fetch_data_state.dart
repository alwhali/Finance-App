part of 'fetch_data_cubit.dart';

@immutable
sealed class FetchDataState {}

final class FetchDataInitial extends FetchDataState {}

final class FetchDataLoading extends FetchDataState {}

final class FetchDataSuccess extends FetchDataState {}

final class FetchDataError extends FetchDataState {
  final String errorMessage;

  FetchDataError(this.errorMessage);
}
