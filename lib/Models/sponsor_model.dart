import 'dart:convert';

class Sponsor {
  final int id;
  final String title;
  final String desc;
  final String image;
  final String type;
  final String expired_at;
  Sponsor({
    required this.id,
    required this.title,
    required this.desc,
    required this.image,
    required this.type,
    required this.expired_at,
  });
  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        image: json['image'],
        expired_at: json["expired_at"],
        type: json["type"]);
  }
}
