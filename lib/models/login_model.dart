class LogInModel {
  bool? status;
  String? message ;
  LogInData? data ;

  LogInModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] !=null?LogInData.fromJson(json['data']):null ;
  }
}

class LogInData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  LogInData.fromJson(Map<String,dynamic> data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    points = data['points'];
    credit = data['credit'];
    token = data['token'];
  }
}