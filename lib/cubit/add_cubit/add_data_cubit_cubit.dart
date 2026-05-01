import 'package:bloc/bloc.dart';
import 'package:finance_app/models/finance_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'add_data_cubit_state.dart';

class AddDataCubit extends Cubit<AddDataState> {
  AddDataCubit() : super(AddDataCubitInitial());

  addData(FinanceModel financeModel) async {
    try {
      emit(AddDataCubitLoading());
      await Hive.box<FinanceModel>("finance_box").add(financeModel);

      emit(AddDataCubitSuccess());
    } on Exception catch (e) {
      emit(AddDataCubitError(e.toString()));
    }
  }
}
