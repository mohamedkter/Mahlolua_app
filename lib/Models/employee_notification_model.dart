class EmployeeNotification {
  final int orderId;
  final String timestamp;

  EmployeeNotification({
    required this.orderId,
    required this.timestamp,
  });

  factory EmployeeNotification.fromJson(Map<String, dynamic> json) {
    return EmployeeNotification(
      orderId: json['order_id'],
      timestamp:json['timestamp'],
    );
  }
}