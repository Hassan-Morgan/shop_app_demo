import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import 'login_states.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitialState());

  static LogInCubit get(context) => BlocProvider.of(context);

  LogInModel? logInModel;

  void postLogInData({
    required String email,
    required String password,
    required language,
  }) {
    emit(LogInLoadingState());
    DioHelper.postData(language: language, path: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      logInModel = LogInModel.fromJson(value.data);
      emit(LogInSuccessState(logInModel!));
    }).catchError((error) {
      emit(LogInErrorState());
    });
  }
}
