class Reservation {
  String id;
  int employeeId;
  String username;
  String employeeName;
  String serviceName;
  String dateOfDelivery;
  Location location;
  String status; // Add this field
  String orderdescription;
  String price;
  String? price_after_discount;
  String? total_discount;
  String? userImage;
  Reservation(
      {required this.id,
      required this.employeeName,
      required this.serviceName,
      required this.dateOfDelivery,
      required this.location,
      required this.userImage,
      required this.status,
      required this.price,
      required this.username,
      required this.orderdescription,
      required this.employeeId ,
      required this.total_discount,
      required this.price_after_discount// Add this field
      });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'].toString(),
      userImage: json['user']['image'],
      price: json['price'],
      employeeName: json['employee']['user']['name'],
      location: Location.fromJson(json['location']),
      serviceName: json['employee']['service']['name'],
      dateOfDelivery: json['date_of_delivery'],
      orderdescription: json['order_descriptions'],
      status: json['status'],
      username: json['user']['name'],
      employeeId: json['employee']['id'], 
      price_after_discount: json['price_after_discount'],
      total_discount: json['total_discount'],// Add this field
    );
  }
}

class Location {
  int id;
  String city;
  String street;
  String bitTitle;
  String specialMarque;
  double lat;
  double long;

  Location({
    required this.id,
    required this.city,
    required this.street,
    required this.bitTitle,
    required this.specialMarque,
    required this.lat,
    required this.long,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      city: json['city'],
      street: json['street'],
      bitTitle: json['bitTitle'],
      specialMarque: json['specialMarque'],
      lat: json['lat'],
      long: json['long'],
    );
  }
}
