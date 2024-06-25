class UserNotification {
  final int orderId;
  final String employeename;
  final String message;
  
  final String timestamp;

  UserNotification({
    required this.orderId,
    required this.employeename,
    required this.message,
    
    required this.timestamp,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      orderId: json['order_id'],
      employeename: json['employee_name'],
      message: json['message'],
      
      timestamp:json['timestamp'],
    );
  }
}