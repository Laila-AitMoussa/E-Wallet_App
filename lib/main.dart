import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:wallet_app/models/wallet_model.dart';
import 'package:wallet_app/screens/spalsh_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(WalletModelAdapter());
  await Hive.openBox<WalletModel>('walletBox');
  await Hive.openBox('darkModeBox');
  runApp(const WalletApp());
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchDataCubit(),
      child: ValueListenableBuilder(
        valueListenable: Hive.box('darkModeBox').listenable(),
        builder: (BuildContext context, Box<dynamic> box, Widget? child) {
          var darkMode = box.get('darkMode', defaultValue: false);

          return MaterialApp(
            title: 'E-Wallet App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(),
            home: const SpalshPage(),
          );
        },
      ),
    );
  }
}
