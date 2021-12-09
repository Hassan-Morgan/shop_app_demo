import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/signup_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import 'signup_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  SignUpModel? signUpModel;

  void postSignUpData({
    required String userName,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(language: 'en', path: SIGN_UP, data: {
      'name': userName,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      signUpModel = SignUpModel.fromJson(value.data);
      emit(SignUpSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState());
    });
  }
}
