class Reservation {
  String id;
  String username;
  String employeeName;
  String serviceName;
  String dateOfDelivery;
  String location;
  String status; // Add this field
  String orderdescription;
  String price;
  Reservation({
    required this.id,
    required this.employeeName,
    required this.serviceName,
    required this.dateOfDelivery,
    required this.location,
    required this.status,
              required this.price,
    required this.username,
    required this.orderdescription // Add this field
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'].toString(),
      price: json['price'],
      employeeName: json['employee']['user']['name'],
      location: json['location'],
      serviceName: json['employee']['service']['name'],
      dateOfDelivery: json['date_of_delivery'],
      orderdescription:json['order_descriptions'],
      status: json['status'],
      username: json['user']['name'] // Add this field
    );
  }
}
