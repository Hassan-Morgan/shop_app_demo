import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/change_password_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_page_model.dart';
import 'package:shop_app/models/serch_model.dart';
import 'package:shop_app/models/serch_model.dart';
import 'package:shop_app/models/serch_model.dart';
import 'package:shop_app/models/update_profile_model.dart';
import 'package:shop_app/models/user_data_model.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int navBarCurrentIndex = 0;
  HomePageModel? homePageModel;
  CategoriesModel? categoriesModel;
  late Map<int, bool> favorites = {};
  ChangeFavoritesModel? changeFavoritesModel;
  Favorites? favoritesModel;
  UserModel? userModel;
  UpdateProfileModel? updateProfileModel;
  ChangePasswordModel? changePasswordModel;
  SearchModel? searchModel;
  void changeNavBarIndex({
    required int index,
  }) {
    navBarCurrentIndex = index;
    emit(ChangeNavBarIndexState());
    if (homePageModel == null) getHomeDataFromApi();
    if (categoriesModel == null) getCategoriesFromApi();
  }

  void getHomeDataFromApi() {
    emit(GetDataFromApiLoadingState());
    DioHelper.getData(
        path: HOME, language: 'en', token: CashHelper.getData(key: 'token'))
        .then((value) {
      homePageModel = HomePageModel.fromJson(value.data);
      for (var element in homePageModel!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(GetDataFromApiSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataFromApiErrorState());
    });
  }

  void getCategoriesFromApi() {
    emit(GetDataFromApiLoadingState());
    DioHelper.getData(path: CATEGORIES, language: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetDataFromApiSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataFromApiErrorState());
    });
  }

  void changeFavorites({
    required int id,
  }) {
    favorites[id] == true ? favorites[id] = false : favorites[id] = true;
    emit(ChangeFavoritesState());
    DioHelper.postData(
        path: FAVORITES,
        data: {'product_id': id},
        language: 'en',
        token: CashHelper.getData(key: 'token'))
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[id] == true ? favorites[id] = false : favorites[id] = true;
      } else {
        getFavorites();
      }
      emit(ChangeFavoritesSuccessState(changeFavoritesModel));
    }).catchError((error) {
      favorites[id] == true ? favorites[id] = false : favorites[id] = true;
      print(error.toString());
      emit(ChangeFavoritesErrorState());
    });
  }

  void getFavorites() {
    emit(GetFavoritesFromApiLoadingState());
    DioHelper.getData(
        path: FAVORITES,
        language: 'en',
        token: CashHelper.getData(key: 'token'))
        .then((value) {
      favoritesModel = Favorites.fromJson(value.data);
      emit(GetFavoritesFromApiSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesFromApiErrorState());
    });
  }

  void getUserProfile() {
    DioHelper.getData(
        path: PROFILE,
        language: 'en',
        token: CashHelper.getData(key: 'token'))
        .then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(GetDataFromApiSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataFromApiErrorState());
    });
  }

  void updateUserData({
    required String newName,
    required String newEmail,
    required String newPhone,
  }) {
    emit(ChangeUserDataLoadingState());
    DioHelper.putData(
      path: UPDATE_PROFILE,
      language: 'en',
      token: CashHelper.getData(key: 'token'),
      data: {
        'name': newName,
        'phone': newPhone,
        'email': newEmail
      },
    ).then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      emit(ChangeUserDataSuccessState());
      if (updateProfileModel!.status) {
        getUserProfile();
      }
    }).catchError((error) {
      print(error.toString());
      emit(ChangeUserDataErrorState());
    });
  }

  void changePassword(
      {required String currentPassword, required String newPassword}) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
      path: CHANGE_PASSWORD,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword
      },
      language: 'en',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      print(changePasswordModel!.message);
      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChangePasswordErrorState());
    });
  }

  void search({
    required String search,
  }) {
    emit(GetDataFromApiLoadingState());
    DioHelper.postData(
      path: SEARCH,
      data: {
        'text': search,
      },
      language: 'en',
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(GetDataFromApiSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataFromApiErrorState());
    });
  }
}
