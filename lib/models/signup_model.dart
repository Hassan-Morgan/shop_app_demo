class SignUpModel {
  bool? status;
  String? message;
  SignUpData? data;

  SignUpModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = data = json['data'] !=null?SignUpData.fromJson(json['data']):null ;
  }
}
class SignUpData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  SignUpData.fromJson(Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    token = data['token'];
  }
}