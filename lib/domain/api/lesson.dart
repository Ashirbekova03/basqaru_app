import 'dart:convert';

import 'package:basqary/domain/api/base.dart';
import 'package:basqary/presentation/data/LessonViewModel.dart';
import 'package:dio/dio.dart';

class LessonAPI {

  Future<List<LessonViewModel>> findAll() async {
    Response response = await BaseAPI.dio.get("/lessons/all");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<LessonViewModel>.from(parsedListJson.map<LessonViewModel>((dynamic i) => LessonViewModel.fromJson(i)));
  }

}