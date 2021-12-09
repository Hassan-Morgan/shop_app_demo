class ChangePasswordModel{
  late bool status;
  late String message;

  ChangePasswordModel.fromJson(Map<String,dynamic>jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
  }
}