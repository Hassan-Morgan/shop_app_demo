class UpdateProfileModel{
  late bool status;
  late String message;

  UpdateProfileModel.fromJson(Map<String,dynamic>jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
  }
}