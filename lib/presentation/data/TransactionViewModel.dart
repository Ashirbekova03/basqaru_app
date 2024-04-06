import 'package:basqary/presentation/data/CategoryViewModel.dart';

class TransactionViewModel {

  int id;
  CategoryViewModel category;
  double amount;
  bool isReceive;
  int dateTime;

  TransactionViewModel({
    required this.id,
    required this.category,
    required this.amount,
    required this.isReceive,
    required this.dateTime
  });

  factory TransactionViewModel.fromJson(Map<String, dynamic> json) {
    return TransactionViewModel(
      id: json['id'],
      category: CategoryViewModel.fromJson(json['category']),
      amount: json['amount'],
      isReceive: json['isReceive'],
      dateTime: json['dateTime'],
    );
  }
}