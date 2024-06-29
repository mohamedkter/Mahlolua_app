class LocationModel {
  int? id;
  int user_id;
  String city;
  String street;
  String bitTitle;
  String specialMarque;
  double lat;
  double long;

  LocationModel(
  
    {
    required this.user_id,
    required this.city,
    required this.street,
    required this.bitTitle,
    required this.specialMarque,
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'city': city,
      'street': street,
      'bitTitle': bitTitle,
      'specialMarque': specialMarque,
      'lat': lat,
      'long': long,
    };
  }
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['city']  ,
      street: json['street'],
      bitTitle: json['bitTitle'],
      specialMarque: json['specialMarque'],
      lat: json['lat'],
      long: json['long'], user_id: json["user"]["id"],
    );
  }
}