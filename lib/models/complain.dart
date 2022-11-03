// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'dart:convert';
class Complain {
  final int id;
  final String problem;
  final String desc;
  final String address;
  final int pincode;
  final DateTime comTime;

  Complain({
    required this.id,
    required this.problem,
    required this.desc,
    required this.address,
    required this.pincode,
    required this.comTime,
  });

  Complain copyWith({
    int? id,
    String? problem,
    String? desc,
    String? address,
    int? pincode,
    DateTime? comTime,
  }) {
    return Complain(
      id: id ?? this.id,
      problem: problem ?? this.problem,
      desc: desc ?? this.desc,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      comTime: comTime ?? this.comTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'problem': problem,
      'desc': desc,
      'address': address,
      'pincode': pincode,
      'comTime': comTime.millisecondsSinceEpoch,
    };
  }

  factory Complain.fromMap(Map<String, dynamic> map) {
    return Complain(
      id: map['id'] as int,
      problem: map['problem'] as String,
      desc: map['desc'] as String,
      address: map['address'] as String,
      pincode: map['pincode'] as int,
      comTime: DateTime.fromMillisecondsSinceEpoch(map['comTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Complain.fromJson(String source) =>
      Complain.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Complain(id: $id, problem: $problem, desc: $desc, address: $address, pincode: $pincode, comTime: $comTime)';
  }

  @override
  bool operator ==(covariant Complain other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.problem == problem &&
        other.desc == desc &&
        other.address == address &&
        other.pincode == pincode &&
        other.comTime == comTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        problem.hashCode ^
        desc.hashCode ^
        address.hashCode ^
        pincode.hashCode ^
        comTime.hashCode;
  }
}

// class CompalinModel {
//   static List<Complain> complains;

//   // Get Item by ID
//   static Complain getById(int id) =>
//       complains.firstWhere((element) => element.id == id, orElse: null);

//   // Get Item by position
//   static Complain getByPosition(int pos) => complains[pos];
// }

// class Complain {
//   final int id;
//   final String problem;
//   final String desc;
//   final String address;
//   final int pincode;
//   final DateTime comTime;

//   Complain({
//     required this.id,
//     required this.problem,
//     required this.desc,
//     required this.address,
//     required this.pincode,
//     required this.comTime,
//   });
  
  
// // }


//   Complain copyWith({
//     int id,
//     String problem,
//     String desc,
//     String address,
//     int pincode,
//     DateTime comTime,
//   }) {
//     return Complain(
//       id: id ?? this.id,
//       problem: problem ?? this.problem,
//       desc: desc ?? this.desc,
//       address: address ?? this.address,
//       pincode: pincode ?? this.pincode,
//      comTime:comTime ?? this.comTime,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'problem': problem,
//       'desc': desc,
//       'address': address,
//       'pincode': pincode,
//       'comTime': comTime,
//     };
//   }

//   factory Complain.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Complain(
//       id: map['id'],
//       problem: map['problem'],
//       desc: map['desc'],
//       address: map['address'],
//       pincode: map['pincode'],
//       comTime: map['comTime'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Complain.fromJson(String source) => Complain.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Item(id: $id, name: $name, desc: $desc, price: $price, color: $color, image: $image)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Item &&
//         o.id == id &&
//         o.name == name &&
//         o.desc == desc &&
//         o.price == price &&
//         o.color == color &&
//         o.image == image;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         desc.hashCode ^
//         price.hashCode ^
//         color.hashCode ^
//         image.hashCode;
//   }
// }
