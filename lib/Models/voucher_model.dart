class Voucher {
    int id;
    String code;
    String type;
    int discount;
    String status;
    String expiredAt;
  
    Voucher({
        required this.id,
        required this.code,
        required this.type,
        required this.discount,
        required this.status,
        required this.expiredAt,
    });

    factory Voucher.fromJson(Map<String, dynamic> json) {
        return Voucher(
            id: json['id'],
            code: json['code'],
            type: json['type'],
            discount: json['discount'],
            status: json['status'],
            expiredAt: json['expired_at'],
        );
    }
}