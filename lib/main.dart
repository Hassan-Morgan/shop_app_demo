import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_home_layout.dart';
import 'package:shop_app/modules/login_page/login.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/cubit/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.initDio();
  await CashHelper.init();
  dynamic onBoarding = CashHelper.getData(key: 'onBoarding');
  token = CashHelper.getData(key: 'token');
  print(CashHelper.getData(key: 'token'));
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayOut();
    } else {
      widget = LogInPage();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit()
        ..getHomeDataFromApi()
        ..getCategoriesFromApi()
        ..getFavorites()
        ..getUserProfile(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: lightTheme,
        home: widget,
      ),
    );
  }
}
