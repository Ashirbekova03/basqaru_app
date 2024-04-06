class AddCategoryRequest {
  String name;
  String imageUrl;
  double limit;

  AddCategoryRequest({
    required this.name,
    required this.imageUrl,
    required this.limit
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "imageUrl": imageUrl,
      "limit": limit
    };
  }
}