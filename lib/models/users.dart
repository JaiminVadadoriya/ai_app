import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  // int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? password;

  Users({
    // this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
  @override
  String toString() =>
      'name: $name \n phone: $phone \n email: $email \n password: $password \n';
  //constructor that convert json to object instance
  Users.fromJson(Map<String, dynamic> json)
      :
        // id = json['id'],
        name = json['name'],
        phone = json['phone'],
        email = json['email'],
        password = json['password'];

  factory Users.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Users(
      name: data?['name'],
      phone: data?['phone'],
      email: data?['email'],
      password: data?['password'],
    );
  }

  Map<String, dynamic> toFirestore() {
    // 'id': id,
    return {
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (password != null) 'password': password,
    };
  }

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        // 'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      };
}
