import 'package:bloc/bloc.dart';
import 'package:finance_app/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  List<FinanceModel> financeDataList = [];
  List<FinanceModel> financeDataDateList = [];
  List<FinanceModel> todayFinanceDataList = [];

  double sumTotalBalance = 0;
  double sumToDayBalance = 0;
  fetchData() {
    try {
      emit(FetchDataLoading());
      financeDataList = Hive.box<FinanceModel>('finance_box').values.toList();
      todayFinanceDataList = fetchDateDate(DateTime.now());
      fetchDateDate(DateTime.now());
      sumTotalBalance = 0;
      for (var element in financeDataList) {
        sumTotalBalance += element.financeValue;
      }
      sumToDayBalance = 0;
      for (var element in todayFinanceDataList) {
        sumToDayBalance += element.financeValue;
      }
      emit(FetchDataSuccess());
    } catch (e) {
      emit(FetchDataError(e.toString()));
    }
    return financeDataList;
  }

  fetchDateDate(DateTime date) {
    financeDataDateList = Hive.box<FinanceModel>(
      'finance_box',
    ).values.where((element) => element.dateTime.day == date.day).toList();

    return financeDataDateList;
  }
}
