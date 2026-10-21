import 'dart:convert';
class StoryView1 {
  final int newsID;
  final String newsDate;
  final String newsTitle;
  final String imagePath;
  final String providerName;
  final String newsLink;
  final String providerLogo;
  final String newsDisclaimer;
  final String newsBody;
  StoryView1(
      this.newsID,
      this.newsDate,
      this.newsTitle,
      this.imagePath,
      this.providerName,
      this.newsLink,
      this.providerLogo,
      this.newsDisclaimer,
      this.newsBody);
  factory StoryView1.fromJson(Map<String, dynamic> json) {
    return StoryView1(
        json['newsID'],
        json['newsDate'],
        json['newsTitle'],
        json['imagePath'],
        json['providerName'],
        json['newsLink'],
        json['providerLogo'],
        json['newsDisclaimer'],
        json['newsBody']);
  }
  static List<StoryView1> parseList(List<dynamic> list) {
    return list.map((i) => StoryView1.fromJson(i)).toList();
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
        "newsID": newsID,
        "newsTitle": newsTitle,
        "imagePath": imagePath,
        "providerName": providerName,
        "newsLink": newsLink,
        "providerLogo": providerLogo,
        "newsDisclaimer": newsDisclaimer,
        "newsBody": newsBody,
      };
}