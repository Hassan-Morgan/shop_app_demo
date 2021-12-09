import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio ;

  static initDio(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    required String language,
    String token='',
    Map<String,dynamic>? query,
}){
    dio.options.headers ={
      'Content-Type':'application/json',
      'lang':language,
      'authorization':token,
    };
    return dio.get(path);
  }

  static Future<Response> postData({
    required String path,
    required dynamic data,
    Map<String,dynamic>? query,
    required String language ,
    String token ='',
})async{
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':language,
      'authorization':token,
    };
   return dio.post(
    path,
    data: data,
    queryParameters:  query,

   );
  }

  static Future<Response> putData({
    required String path,
    required dynamic data,
    Map<String,dynamic>? query,
    required String language ,
    String token ='',
  })async{
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':language,
      'authorization':token,
    };
    return dio.put(
      path,
      data: data,
    );
  }

}