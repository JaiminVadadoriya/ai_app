// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'dart:convert';
class Complain {
  int? id;
  final String problem;
  final String desc;
  final String address;
  final int pincode;
  // final DateTime comTime;
  // final LatLng currentLoc;
  // final LatLng problemLoc;

  Complain({
    this.id,
    required this.problem,
    required this.desc,
    required this.address,
    required this.pincode,
  });

//   Complain copyWith({
//     int? id,
//     String? problem,
//     String? desc,
//     String? address,
//     int? pincode,
//   }) {
//     return Complain(
//       id ?? this.id,
//       problem ?? this.problem,
//       desc ?? this.desc,
//       address ?? this.address,
//       pincode ?? this.pincode,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'problem': problem,
//       'desc': desc,
//       'address': address,
//       'pincode': pincode,
//     };
//   }

//   factory Complain.fromMap(Map<String, dynamic> map) {
//     return Complain(
//       map['id'] as int,
//       map['problem'] as String,
//       map['desc'] as String,
//       map['address'] as String,
//       map['pincode'] as int,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Complain.fromJson(String source) =>
//       Complain.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Complain(id: $id, problem: $problem, desc: $desc, address: $address, pincode: $pincode)';
//   }

//   @override
//   bool operator ==(covariant Complain other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.problem == problem &&
//         other.desc == desc &&
//         other.address == address &&
//         other.pincode == pincode;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         problem.hashCode ^
//         desc.hashCode ^
//         address.hashCode ^
//         pincode.hashCode;
//   }
}
