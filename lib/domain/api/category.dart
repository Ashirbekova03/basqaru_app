import 'dart:convert';

import 'package:basqary/domain/api/base.dart';
import 'package:basqary/domain/data/category/request/AddCategoryRequest.dart';
import 'package:basqary/presentation/data/CategoryViewModel.dart';
import 'package:dio/dio.dart';

class CategoryAPI {

  Future<List<CategoryViewModel>> findAll() async {
    Response response = await BaseAPI.dio.get("/category");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<CategoryViewModel>.from(parsedListJson.map<CategoryViewModel>((dynamic i) => CategoryViewModel.fromJson(i)));
  }

  Future<dynamic> addCategory(AddCategoryRequest category) async {
    Response response = await BaseAPI.dio.post(
        "/category",
        data: category.toJson()
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error!');
    }
  }

}