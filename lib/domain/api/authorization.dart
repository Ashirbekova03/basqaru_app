import 'dart:convert';

import 'package:basqary/domain/api/base.dart';
import 'package:basqary/domain/data/user/request/LoginRequest.dart';
import 'package:basqary/domain/data/user/request/RegisterRequest.dart';
import 'package:basqary/domain/data/user/response/TokenResponse.dart';
import 'package:dio/dio.dart';

class AuthorizationAPI {

  Future<TokenResponse> login(LoginRequest loginRequest) async {
    Response response = await BaseAPI.dio.post(
        "/auth/login",
        data: loginRequest.toJson()
    );
    if (response.statusCode == 200) {
      var tokenResponse = TokenResponse.fromJson(jsonDecode(response.data));
      await BaseAPI.userProvider.setAuthToken(tokenResponse.token);
      await BaseAPI.reloadTokenHeader(tokenResponse.token);
      return tokenResponse;
    } else {
      throw Exception('Wrong email or password!');
    }
  }

  Future<dynamic> register(RegisterRequest registerRequest) async {
    Response response = await BaseAPI.dio.post(
        "/auth/register",
        data: registerRequest.toJson()
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Phone already registered');
    }
  }


}