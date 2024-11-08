// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'shift_model.dart';

class CompanyModel {
  static List<RegionModel> regionList = [
    // RegionModel(id: 1, name: 'vung a', note: 'n v a', branchList: [
    //   BranchModel(id: 1, name: 'chi nhanh a1', note: '', regionName: 'vung a',regionID: 1),
    //   BranchModel(id: 2, name: 'chi nhanh a2', note: '', regionName: 'vung a',regionID: 1)
    // ]),
    // RegionModel(id: 2, name: 'vung b', note: 'n v b', branchList: [
    //   BranchModel(
    //       id: 1, name: 'chi nhanh b1', note: 'note1', regionName: 'vung b',regionID: 2),
    //   BranchModel(id: 2, name: 'chi nhanh b2', note: '', regionName: 'vung b',regionID: 2),
    //   BranchModel(
    //       id: 3, name: 'chi nhanh b3', note: 'note3', regionName: 'vung b',regionID: 2)
    // ]),
  ];
  static List<LocationModel> locationList = [];
  static LocationModel? currentLocation;
  static ShiftModel? shiftModel;
  static bool checkInStatus = false;
}

class RegionModel {
  int id;
  String name;
  String description;
  RegionModel({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionModel.fromJson(String source) =>
      RegionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
// class RegionModel {
//   int id;
//   String name;
//   String note;
//   List<BranchModel> branchList;
//   RegionModel(
//       {required this.id,
//       required this.name,
//       required this.note,
//       required this.branchList});
//   RegionModel copyWith(
//       {int? id, String? name, String? note, List<BranchModel>? branchList}) {
//     return RegionModel(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         note: note ?? this.note,
//         branchList: branchList ?? this.branchList);
//   }
// }

class BranchModel {
  int id;
  String name;
  int areaID;
  String description;
  BranchModel({
    required this.id,
    required this.name,
    required this.areaID,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'areaID': areaID,
      'description': description,
    };
  }

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'] as int,
      name: map['name'] as String,
      areaID: map['areaID'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchModel.fromJson(String source) =>
      BranchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LocationModel {
  int id;
  String name;
  String address;
  double lat;
  double lng;
  int branchID;
  int? radius;
  LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.branchID,
    this.radius,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'latitude': lat,
      'longitude': lng,
      'branchID': branchID,
      'radius': radius,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as int,
      name: map['name'] as String,
      address: map['address'] as String,
      lat: (map['latitude'] is int)
          ? (map['latitude'] as int).toDouble()
          : map['latitude'] as double,
      lng: (map['longitude'] is int)
          ? (map['longitude'] as int).toDouble()
          : map['longitude'] as double,
      branchID: map['branchID'] as int,
      radius: (map['radius'] != null && map['radius'] is int)
          ? (map['radius'] as int)
          : map['radius'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  LocationModel copyWith({
    int? id,
    String? name,
    String? address,
    double? lat,
    double? lng,
    int? branchID,
    int? radius,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      branchID: branchID ?? this.branchID,
      radius: radius ?? this.radius,
    );
  }
}

class PlaceSearchModel {
  final String description;
  final String placeId;
  PlaceSearchModel({required this.description, required this.placeId});
  PlaceSearchModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        placeId = json['place_id'];
}

class PlaceModel {
  final GeometryModel geometry;
  final String name;
  PlaceModel({required this.geometry, required this.name});
  PlaceModel.fromJson(Map<String, dynamic> json)
      : geometry = GeometryModel.fromJson(json['geometry']),
        name = json['formatted_address'];
}

class GeometryModel {
  final CoordinatesModel coordinates;
  GeometryModel({required this.coordinates});
  GeometryModel.fromJson(Map<dynamic, dynamic> json)
      : coordinates = CoordinatesModel.fromJson(json['location']);
}

class CoordinatesModel {
  final double lat;
  final double lng;
  CoordinatesModel({required this.lat, required this.lng});
  CoordinatesModel.fromJson(Map<dynamic, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];
}
