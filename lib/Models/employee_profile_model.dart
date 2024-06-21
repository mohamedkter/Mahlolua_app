class EmployeeProfile {
  final String desc;
  final String SSN;
  final int minPrice;
  final int userId;
  final int serviceId;

  EmployeeProfile({
    required this.desc,
    required this.SSN,
    required this.minPrice,
    required this.userId,
    required this.serviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'nationalId': SSN,
      'min_price': minPrice,
      'user_id': userId,
      'service_id': serviceId,
      
    };
  }
}
