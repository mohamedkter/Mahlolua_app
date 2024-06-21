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

}