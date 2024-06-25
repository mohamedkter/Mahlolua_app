class Feedback {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? comment;
  String? rating;
  int? employeeId;
  User? user;

  Feedback(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.comment,
      this.rating,
      this.employeeId,
      this.user});

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    comment = json['comment'];
    rating = json['rating'];
    employeeId = json['employee_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }
}