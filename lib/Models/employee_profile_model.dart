class EmployeeProfile {
  final String desc;
  final String imageSSN;
  final String imageLive;
  final int SSN;
  final int minPrice;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final int userId;
  final int serviceId;

  EmployeeProfile({
    required this.desc,
    required this.imageSSN,
    required this.imageLive,
    required this.SSN,
    required this.minPrice,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.userId,
    required this.serviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'imageSSN': imageSSN,
      'livePhoto': imageLive,
      'nationalId': SSN,
      'min_price': minPrice,
      'user_id': userId,
      'service_id': serviceId,
      'works[0]': image1,
      'works[1]': image2,
      'works[2]': image3,
      'works[3]': image4,
    };
  }
}
