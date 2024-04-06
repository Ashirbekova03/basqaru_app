class LessonViewModel {
  int id;
  int time;
  String title;
  String description;
  String contentUrl;

  LessonViewModel({
    required this.id,
    required this.time,
    required this.title,
    required this.description,
    required this.contentUrl
  });

  factory LessonViewModel.fromJson(Map<String, dynamic> json) {
    return LessonViewModel(
      id: json['id'],
      time: json['time'],
      title: json['title'],
      description: json['data'],
      contentUrl: json['contentUrl'],
    );
  }

}