class Order {
   int? price;
   int? locationId;
   String? dateOfDelivery;
   String? orderDescriptions;
   //String? voucherCode;
   int? userId;
   int? employeeId;

  Order({
     this.price,
     this.locationId,
     this.dateOfDelivery,
     this.orderDescriptions,
     //this.voucherCode,
     this.userId,
     this.employeeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'location_id': locationId,
      'date_of_delivery': dateOfDelivery,
      'order_descriptions': orderDescriptions,
      //'voucher_code': voucherCode != null? voucherCode : 'empty',
      'user_id': userId,
      'employee_id': employeeId,
    };
  }
}