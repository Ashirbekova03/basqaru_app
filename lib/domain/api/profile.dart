import 'dart:convert';

import 'package:basqary/domain/api/base.dart';
import 'package:basqary/domain/data/user/request/ChangeProfileRequest.dart';
import 'package:basqary/domain/data/user/request/PasswordChangeRequest.dart';
import 'package:basqary/domain/data/user/response/ProfileResponse.dart';
import 'package:basqary/domain/data/user/response/TokenResponse.dart';
import 'package:dio/dio.dart';

class ProfileAPI {

  Future<ProfileViewModel> getProfile() async {
    Response response = await BaseAPI.dio.get("/profile");
    if (response.statusCode == 200) {
      return ProfileViewModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception("Profile not found");
    }
  }

  Future<dynamic> changeProfile(ChangeProfileRequest request) async {
    Response response = await BaseAPI.dio.post(
      "/profile",
      data: request.toJson()
    );
    if (response.statusCode == 200) {
      var tokenResponse = TokenResponse.fromJson(jsonDecode(response.data));
      await BaseAPI.userProvider.setAuthToken(tokenResponse.token);
      await BaseAPI.reloadTokenHeader(tokenResponse.token);
      await BaseAPI.reloadHeader();
      return tokenResponse;
    } else {
      throw Exception('Email already exists!');
    }
  }

  Future<dynamic> changePassword(PasswordChangeRequest request) async {
    Response response = await BaseAPI.dio.post(
      "/profile/password",
      data: request.toJson()
    );
    if (response.statusCode == 200) {
      var tokenResponse = TokenResponse.fromJson(jsonDecode(response.data));
      await BaseAPI.userProvider.setAuthToken(tokenResponse.token);
      await BaseAPI.reloadTokenHeader(tokenResponse.token);
      await BaseAPI.reloadHeader();
      return tokenResponse;
    } else {
      throw Exception('Error!');
    }
  }
}