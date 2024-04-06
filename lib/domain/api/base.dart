import 'package:basqary/domain/provider/UserProvider.dart';
import 'package:dio/dio.dart';

class BaseAPI {

  static var userProvider = UserProvider();

  static var dio = Dio(
      BaseOptions(
          baseUrl: "http://192.168.0.11:8080/api",
          responseType: ResponseType.plain,
          connectTimeout: const Duration(minutes: 3),
          receiveTimeout: const Duration(minutes: 3),
          headers: {
            "Content-Type": "application/json",
          }
      )
  );

  static Future<dynamic> reloadHeader() async {
    await userProvider.getAuthToken().then((value) => {
      if (value != null) {
        dio.options.headers = {
          "Content-Type": "application/json",
          "Authorization": value.toString()
        }
      } else {
        dio.options.headers = {
          "Content-Type": "application/json",
        }
      },
    });
  }

  static Future<dynamic> reloadTokenHeader(String token) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": token
    };
  }

}