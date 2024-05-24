import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:wallet_app/models/wallet_model.dart';

part 'add_data_state.dart';

class AddDataCubit extends Cubit<AddDataState> {
  AddDataCubit() : super(AddDataInitial());

  addData(WalletModel walletModel) async {
    emit(AddDataLoading());
    try {
      await Hive.box<WalletModel>('walletBox').add(walletModel);
      emit(AddDataSuccess());
    } on Exception catch (e) {
      emit(AddDataFailure(e.toString()));
    }
  }
}
