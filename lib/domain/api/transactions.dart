import 'dart:convert';

import 'package:basqary/domain/api/base.dart';
import 'package:basqary/domain/data/transaction/request/AddTransactionRequest.dart';
import 'package:basqary/domain/data/transaction/request/PeriodFilter.dart';
import 'package:basqary/presentation/data/TransactionViewModel.dart';
import 'package:dio/dio.dart';

class TransactionsAPI {

  Future<List<TransactionViewModel>> findAll() async {
    Response response = await BaseAPI.dio.get("/transaction");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<TransactionViewModel>.from(parsedListJson.map<TransactionViewModel>((dynamic i) => TransactionViewModel.fromJson(i)));
  }

  Future<List<TransactionViewModel>> filter(PeriodFilter periodFilter) async {
    Response response = await BaseAPI.dio.get(
      "/transaction/period",
      data: periodFilter.toJson()
    );
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<TransactionViewModel>.from(parsedListJson.map<TransactionViewModel>((dynamic i) => TransactionViewModel.fromJson(i)));
  }

  Future<dynamic> add(AddTransactionRequest transaction) async {
    Response response = await BaseAPI.dio.post(
        "/transaction",
        data: transaction.toJson()
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error!');
    }
  }

}