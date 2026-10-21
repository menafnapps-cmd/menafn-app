import 'dart:convert';
class Photo {
  final int newsid;
  final String newsdate;
  final String title;
  final String picture;
  final String company;
  final String link;
  Photo(this.newsid, this.newsdate, this.title, this.picture, this.company,
      this.link);
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(json["newsid"],
        json["newsdate"],
        json["title"],
        json["picture"],
        json["company"],
        json["link"]);
  }
  static List<Photo> parseList(List<dynamic> list) {
    return list.map((i) => Photo.fromJson(i)).toList();
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
        "newsid": newsid,
        "newsdate": newsdate,
        "title": title,
        "picture": picture,
        "company": company,
        "link": link,
      };
}