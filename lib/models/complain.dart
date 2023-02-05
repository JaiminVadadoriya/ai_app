// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Complain {
  // final int? id;
  final String? problem;
  final String? description;
  final String? address;
  final int? pincode;
  final String? email;
  final String? problemProcess;
  final Timestamp? complainTime;
  final GeoPoint? currentLocation;
  final GeoPoint? problemLocation;
  final bool? higherAuthority;

  Complain({
    this.higherAuthority = false,
    // this.id,
    required this.problem,
    required this.description,
    required this.address,
    required this.pincode,
    required this.complainTime,
    required this.email,
    required this.problemProcess,
    required this.currentLocation,
    required this.problemLocation,
  });

  // Complain copyWith({
  //   // int? id,
  //   String? problem,
  //   String? description,
  //   String? address,
  //   int? pincode,
  //   String? email,
  //   DateTime? complainTime,
  //   GeoPoint? currentLocation,
  //   GeoPoint? problemLocation,
  // }) {
  //   return Complain(
  //     // id: id ?? this.id,
  //     problem: problem ?? this.problem,
  //     description: description ?? this.description,
  //     address: address ?? this.address,
  //     pincode: pincode ?? this.pincode,
  //     complainTime: complainTime ?? this.complainTime,
  //     email: email ?? this.email,
  //     currentLocation: currentLocation ?? this.currentLocation,
  //     problemLocation: problemLocation ?? this.problemLocation,
  //   );
  // }

  factory Complain.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Complain(
      // 'id': id,
      problem: data?['problem'],
      description: data?['description'],
      address: data?['address'],
      pincode: data?['pincode'],
      complainTime: data?['complainTime'],
      email: data?['email'],
      problemProcess: data?['problemProcess'],
      currentLocation: data?['currentLocation'],
      problemLocation: data?['problemLocation'],
      higherAuthority: data?['higherAuthority'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     // 'id': id,
  //     'problem': problem,
  //     'description': description,
  //     'address': address,
  //     'pincode': pincode,
  //     'complainTime': complainTime?.millisecondsSinceEpoch,
  //     'currentLocation': currentLocation?.toMap(),
  //     'problemLocation': problemLocation?.toMap(),
  //   };
  // }

  Map<String, dynamic> toFirestore() {
    return {
      // 'id': id,
      if (problem != null) 'problem': problem,
      if (description != null) 'description': description,
      if (address != null) 'address': address,
      if (pincode != null) 'pincode': pincode,
      if (complainTime != null) 'complainTime': complainTime,
      if (email != null) 'email': email,
      if (problemProcess != null) 'problemProcess': problemProcess,
      if (currentLocation != null) 'currentLocation': currentLocation,
      if (problemLocation != null) 'problemLocation': problemLocation,
      if (higherAuthority != null) 'higherAuthority': higherAuthority,
      // if (problemLocation != null) 'problemLocation': problemLocation?.toMap(),
    };
  }

  // factory Complain.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,) {
  //      final data = snapshot.data();
  //   return Complain(
  //     problem: map['problem'] != null ? map['problem'] as String : null,
  //     description: map['description'] != null ? map['description'] as String : null,
  //     address: map['address'] != null ? map['address'] as String : null,
  //     pincode: map['pincode'] != null ? map['pincode'] as int : null,
  //     complainTime: map['complainTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['complainTime'] as int) : null,
  //     currentLocation: map['currentLocation'] != null ? GeoPoint.fromMap(map['currentLocation'] as Map<String,dynamic>) : null,
  //     problemLocation: map['problemLocation'] != null ? GeoPoint.fromMap(map['problemLocation'] as Map<String,dynamic>) : null,
  //   );
  // }

  // factory Complain.fromMap(Map<String, dynamic> map) {
  //   return Complain(
  //     id: map['id'] != null ? map['id'] as int : null,
  //     problem: map['problem'] != null ? map['problem'] as String : null,
  //     description: map['description'] != null ? map['description'] as String : null,
  //     address: map['address'] != null ? map['address'] as String : null,
  //     pincode: map['pincode'] != null ? map['pincode'] as int : null,
  //     complainTime: map['complainTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['complainTime'] as int) : null,
  //     currentLocation: map['currentLocation'] != null ? GeoPoint.fromMap(map['currentLocation'] as Map<String,dynamic>) : null,
  //     problemLocation: map['problemLocation'] != null ? GeoPoint.fromMap(map['problemLocation'] as Map<String,dynamic>) : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Complain.fromJson(String source) => Complain.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Complain( problem: $problem, description: $description, address: $address, pincode: $pincode, complainTime: $complainTime, currentLocation: $currentLocation, problemLocation: $problemLocation)';
  }

  // @override
  // bool operator ==(covariant Complain other) {
  //   if (identical(this, other)) return true;

  //   return
  //       // other.id == id &&
  //       other.problem == problem &&
  //           other.description == description &&
  //           other.address == address &&
  //           other.pincode == pincode &&
  //           other.complainTime == complainTime &&
  //           other.currentLocation == currentLocation &&
  //           other.problemLocation == problemLocation &&
  //           other.higherAuthority == higherAuthority;
  // }

  // @override
  // int get hashCode {
  //   return
  //       //  id.hashCode ^
  //       problem.hashCode ^
  //           description.hashCode ^
  //           address.hashCode ^
  //           pincode.hashCode ^
  //           complainTime.hashCode ^
  //           currentLocation.hashCode ^
  //           problemLocation.hashCode;
  // }
}
