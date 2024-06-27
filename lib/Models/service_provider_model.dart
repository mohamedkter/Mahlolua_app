
class ServiceProvider {
  int? id;
  int? total_rates;
  String? average_rating;
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
      this.service,
      this.total_rates,
      this.average_rating});
 static List<ServiceProvider> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray.map((json) {
      return ServiceProvider(
        id: json['employee']['id'],
        desc: json['employee']['desc'],
        minPrice: json['employee']['min_price'],
        status: json['employee']['status'],
        total_rates:json['employee']['total_rates'],
        average_rating:json['employee']['average_rating'],
        user: json['user'] != null ? User.fromJson(json['user']) : null,
        service: json['service'] != null ? Service.fromJson(json['service']) : null,
      );
    }).toList();}
  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total_rates = json["total_rates"];
    average_rating = json["average_rating"];
    desc = json['desc'];
    minPrice = json['min_price'];
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
  User({this.id, this.name, this.email, this.phone, this.image, this.works});

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
class Service{
 final int id;
 final String name;

Service({required this.id, required this.name});
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
    );
  }
}