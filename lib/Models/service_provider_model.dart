import 'package:mahloula/Models/service_model.dart';

class ServiceProvider {
  int? id;
  String? desc;
String? minPrice;
  String? status;
  String? checkByAdmin;
  User? user;
  Service? service;

  ServiceProvider(
      {this.id,
      this.desc,
      this.minPrice,
      this.status,
      this.checkByAdmin,
      this.user,
      this.service});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    minPrice =json['min_price'];
    status = json['status'];
    checkByAdmin = json['checkByAdmin'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }
}
class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  List<Works>? works;
  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.works});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    if (json['works'] != null) {
      works = <Works>[];
      json['works'].forEach((v) {
        works!.add(new Works.fromJson(v));
      });
    }
  }

}

class Works {
  int? id;
  String? imageUrl;
  Works({this.id, this.imageUrl});

  Works.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
  }
}
