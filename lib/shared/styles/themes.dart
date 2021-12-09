import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme =ThemeData(
  fontFamily: 'OpenSans',
  primarySwatch: defaultAppColor,
  appBarTheme:  AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: defaultAppColor,
      fontSize: 22,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black54,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(headline4:TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
    bodyText1: TextStyle(),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultAppColor,
    unselectedItemColor: Colors.black45,
  ),
);