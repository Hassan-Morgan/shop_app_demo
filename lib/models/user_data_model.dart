class UserModel{
  late bool status;
  late UserDataModel data;

  UserModel.fromJson(Map<String,dynamic>jsonData){
    status = jsonData['status'];
    data = UserDataModel.fromJson(jsonData['data']);
  }
}

class UserDataModel{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  UserDataModel.fromJson(Map<String,dynamic>jsonData){
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    token = jsonData['token'];
  }
}