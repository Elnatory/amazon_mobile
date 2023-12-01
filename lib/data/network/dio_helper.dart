import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiContest.baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      receiveDataWhenStatusError: true,
      ),
    );
  }
  // static Future<Response> getDataDio({
  //   required String url,
  //   required Map<String, dynamic> query,
  // }) async {
  //   return await dio.get(
  //     url,
  //     queryParameters: query,
  //   );
  // }

static Future<Response> postDataDio({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(
      url,
      data: data,
    );
  }




}
