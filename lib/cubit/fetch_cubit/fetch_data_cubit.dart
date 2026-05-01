import 'package:bloc/bloc.dart';
import 'package:finance_app/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  List<FinanceModel> financeDataList = [];
  fetchData() {
    try {
      emit(FetchDataLoading());
      financeDataList = Hive.box<FinanceModel>('finance_box').values.toList();
      emit(FetchDataSuccess());
    } catch (e) {
      emit(FetchDataError(e.toString()));
    }
    return financeDataList;
  }
}
