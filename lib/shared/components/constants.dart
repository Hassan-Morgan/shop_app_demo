import 'package:flutter/material.dart';

double width ({required context}){
  return MediaQuery.of(context).size.width;
}
double height ({required context}){
  return MediaQuery.of(context).size.height;
}

String? token;