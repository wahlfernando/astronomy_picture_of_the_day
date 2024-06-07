class APODModel {
  final String title;
  final String date;
  final String explanation;
  final String url;

  APODModel({required this.title, required this.date, required this.explanation, required this.url});

  factory APODModel.fromJson(Map<String, dynamic> json) {
    return APODModel(
      title: json['title'],
      date: json['date'],
      explanation: json['explanation'],
      url: json['url'],
    );
  }
}
