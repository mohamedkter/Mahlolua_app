class EmployeeProfile {
  final String desc;
  final String SSN;
  final int minPrice;
  final int userId;
  final int serviceId;
  final String location;
  EmployeeProfile({
    required this.desc,
    required this.SSN,
    required this.minPrice,
    required this.userId,
    required this.serviceId,
    required this.location, 
  });

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'nationalId': SSN,
      'min_price': minPrice,
      'user_id': userId,
      'service_id': serviceId,
      'location':location
    };
  }
}
