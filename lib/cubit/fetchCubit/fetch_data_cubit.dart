import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:wallet_app/models/wallet_model.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  List<WalletModel> walletList = [];
  List<WalletModel> todayWalletList = [];
  List<WalletModel> dateWalletList = [];
  double sum = 0.0;
  double todaySum = 0.0;
  DateTime selectDay = DateTime.now();
  fetchData() {
    emit(FetchDataLoading());
    try {
      walletList = Hive.box<WalletModel>('walletBox').values.toList();
      todayWalletList = walletList
          .where((element) =>
              DateFormat.yMMMEd().format(element.date) ==
              DateFormat.yMMMEd().format(DateTime.now()))
          .toList();
      fetchDateData(datetime: selectDay);
      sum = 0;
      todaySum = 0;
      for (var element in walletList) {
        sum += element.value;
      }

      for (var element in todayWalletList) {
        todaySum += element.value;
      }
      emit(FetchDataSuccess());
    } on Exception catch (e) {
      emit(FetchDataFailure(e.toString()));
    }
    return walletList;
  }

  fetchDateData({DateTime? datetime}) {
    dateWalletList = walletList
        .where((element) =>
            DateFormat.yMMMEd().format(element.date) ==
            DateFormat.yMMMEd().format(datetime ?? DateTime.now()))
        .toList();
  }
}
