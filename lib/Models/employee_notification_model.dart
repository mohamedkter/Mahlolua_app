class EmployeeNotification {
  final int orderId;
  final String location;
  final String dateOfDelivery;
  final String descriptions;
  final String userName;
  final String timestamp;

  EmployeeNotification({
    required this.orderId,
    required this.location,
    required this.dateOfDelivery,
    required this.descriptions,
    required this.userName,
    required this.timestamp,
  });

  factory EmployeeNotification.fromJson(Map<String, dynamic> json) {
    return EmployeeNotification(
      orderId: json['order_id'],
      location: json['location'],
      dateOfDelivery: json['date_of_delivery'],
      descriptions: json['descriptions'],
      userName: json['user_name'],
      timestamp:json['timestamp'],
    );
  }
}