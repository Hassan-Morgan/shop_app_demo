class ChangeFavoritesModel{
  late bool status;
  late String message;

  ChangeFavoritesModel.fromJson(Map<String,dynamic>jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
  }
}