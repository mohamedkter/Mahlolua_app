class Service{
 final int id;
 final String name;
 final String desc;
 final String image;

Service({required this.id, required this.name, required this.desc, required this.image});
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
    );
  }
}