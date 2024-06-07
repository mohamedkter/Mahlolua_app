class EmployeeProfile {
  final String desc;
  final int minPrice;
  final String image; 
  final int userId;
  final int serviceId;

  EmployeeProfile({
    required this.desc,
    required this.minPrice,
    required this.image,
    required this.userId,
    required this.serviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'min_price': minPrice,
      'image': image,
      'user_id': userId,
      'service_id': serviceId,
    };
  }
}
