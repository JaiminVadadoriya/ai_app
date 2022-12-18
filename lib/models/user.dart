class User {
  int? id;
  final String name;
  final String phone;
  final String email;
  final String password;

  User({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
  @override
  String toString() =>
      'name: $name \n phone: $phone \n email: $email \n password: $password \n';
  //constructor that convert json to object instance
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        email = json['email'],
        password = json['password'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      };
}
