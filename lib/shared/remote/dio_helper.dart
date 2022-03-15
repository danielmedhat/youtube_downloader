import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;
  static inti() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://www.googleapis.com/',
      receiveDataWhenStatusError: true,
      
    ));
  }

  static Future<Response> getDta(
    
      { required Map<String, dynamic> query,
          
          
       required String url}) async {
        
       
    return await dio!.get(
      url,
      queryParameters: query,
      
    );
  }

  // static Future<Response> postData(
  //     {@required Map<String, dynamic> data,
  //     String langue= 'en',
  //     String token,
  //     Map<String, dynamic> query,
  //     @required String url}) async {
  //   dio.options.headers = {
  //     'lang': langue,
  //     'Authorization':token,
  //     'Content-Type': 'application/json'

  //   };
  //   return await dio.post(
  //     url,
  //     data: data,
  //   );
  // }
}
