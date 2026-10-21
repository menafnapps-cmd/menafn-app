// not use this class in application this class use for retrieved data from api use dio
// in this application use api in cubit class
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
class DioHelper
{
static late Dio dio ;
static init()
{
  dio = Dio(
    BaseOptions(
      baseUrl: 'https://menafn.com/mobile/WebAPI/getnews/getsection/',
      receiveDataWhenStatusError: true,
    ),
  );
}
static Future<Response> getData(
    {
      required String url ,
    })
async
{
  return await  dio.get(url);
}
}