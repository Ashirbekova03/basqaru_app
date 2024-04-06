class CategoryViewModel {
  int id;
  String name;
  String imageUrl;
  double limit;

  CategoryViewModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.limit = 0
  });

  factory CategoryViewModel.fromJson(Map<String, dynamic> json) {
    return CategoryViewModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      limit: json['limit'],
    );
  }

}