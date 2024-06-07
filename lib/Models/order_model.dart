class Order {
  final int price;
  final String location;
  final DateTime dateOfDelivery;
  final String orderDescriptions;
  final String? voucherCode; // optional field
  final int userId;
  final int employeeId;

  Order({
    required this.price,
    required this.location,
    required this.dateOfDelivery,
    required this.orderDescriptions,
    this.voucherCode,
    required this.userId,
    required this.employeeId,
  });
  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'location': location,
      'date_of_delivery': dateOfDelivery.toIso8601String(),
      'order_descriptions': orderDescriptions,
      'voucher_code': voucherCode,
      'user_id': userId,
      'employee_id': employeeId,
    };
  }
}
