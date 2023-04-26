/// [User] model refers to the information of the client or the supporter
class User {
  int? id;
  String? fName;
  String? lName;
  String? phoneNumber;
  String? email;

  User({
    this.fName,
    this.lName,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['firstname'] ?? '';
    lName = json['lastname'] ?? '';
    phoneNumber = json['phone'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = fName;
    data['lastname'] = lName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    return data;
  }
}
