class EmployeeOrder {
  String id;
  String username;
  String employeeName;
  String serviceName;
  String dateOfDelivery;
  String location;
  String status; // Add this field
  String orderdescription;
  String price;

  EmployeeOrder(
      {required this.id,
      required this.employeeName,
      required this.serviceName,
      required this.dateOfDelivery,
      required this.location,
      required this.status,
      required this.username,
      required this.orderdescription ,
      required this.price// Add this field
      });
  factory EmployeeOrder.fromJson(Map<String, dynamic> json) {
    return EmployeeOrder(
        id: json['id'].toString(),
        employeeName: json['employee']['user']['name'],
        location: json['location'],
        serviceName: json['employee']['service']['name'],
        dateOfDelivery: json['date_of_delivery'],
        orderdescription: json['order_descriptions'],
        status: json['status'],
        username: json['user']['name'],
        price:json['price'] // Add this field
        );
  }
}
