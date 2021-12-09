import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/update_profile_model.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

class ChangeNavBarIndexState extends ShopAppStates{}

class GetDataFromApiLoadingState extends ShopAppStates{}

class GetDataFromApiSuccessState extends ShopAppStates{}

class GetDataFromApiErrorState extends ShopAppStates{}

class ChangeFavoritesState extends ShopAppStates{}

class ChangeFavoritesSuccessState extends ShopAppStates{
   ChangeFavoritesModel? changeFavoritesModel;
   ChangeFavoritesSuccessState(this.changeFavoritesModel);
}

class ChangeFavoritesErrorState extends ShopAppStates{}

class GetFavoritesFromApiLoadingState extends ShopAppStates{}

class GetFavoritesFromApiSuccessState extends ShopAppStates{}

class GetFavoritesFromApiErrorState extends ShopAppStates{}

class ChangeUserDataLoadingState extends ShopAppStates{}

class ChangeUserDataSuccessState extends ShopAppStates{}

class ChangeUserDataErrorState extends ShopAppStates{}

class ChangePasswordLoadingState extends ShopAppStates{}

class ChangePasswordSuccessState extends ShopAppStates{}

class ChangePasswordErrorState extends ShopAppStates{}



