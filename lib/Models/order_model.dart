class Order {
   int? price;
   String? location;
   String? dateOfDelivery;
   String? orderDescriptions;
   String? voucherCode;
   int? userId;
   int? employeeId;

  Order({
     this.price,
     this.location,
     this.dateOfDelivery,
     this.orderDescriptions,
     this.voucherCode,
     this.userId,
     this.employeeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'location': location,
      'date_of_delivery': dateOfDelivery,
      'order_descriptions': orderDescriptions,
      //'voucher_code': voucherCode,
      'user_id': userId,
      'employee_id': employeeId,
    };
  }
}