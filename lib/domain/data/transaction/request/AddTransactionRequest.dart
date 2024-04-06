class AddTransactionRequest {
  double amount;
  num categoryId;
  bool isReceive;


  AddTransactionRequest({
    required this.amount,
    required this.categoryId,
    required this.isReceive
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "categoryId": categoryId,
      "isReceive": isReceive,
    };
  }
}