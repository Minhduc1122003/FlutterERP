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
  String note;
  List<BranchModel> branchList;
  RegionModel(
      {required this.id,
      required this.name,
      required this.note,
      required this.branchList});
  RegionModel copyWith(
      {int? id, String? name, String? note, List<BranchModel>? branchList}) {
    return RegionModel(
        id: id ?? this.id,
        name: name ?? this.name,
        note: note ?? this.note,
        branchList: branchList ?? this.branchList);
  }
}

class BranchModel {
  int id;
  String name;
  int regionID;
  String regionName;
  String note;
  BranchModel(
      {required this.id,
      required this.name,
      required this.regionName,
      required this.regionID,
      required this.note});

  BranchModel copyWith(
      {int? id,
      String? name,
      int? regionID,
      String? regionName,
      String? note}) {
    return BranchModel(
        id: id ?? this.id,
        name: name ?? this.name,
        regionID: regionID ?? this.regionID,
        regionName: regionName ?? this.regionName,
        note: note ?? this.note);
  }
}

class LocationModel {
  int id;
  String name;
  String address;
  double lat;
  double lng;
  BranchModel branch;
  int radius;
  LocationModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.lat,
      required this.lng,
      required this.branch,
      required this.radius});
  LocationModel copyWith(
      {int? id,
      String? name,
      String? address,
      double? lat,
      double? lng,
      BranchModel? branch,
      int? radius}) {
    return LocationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        branch: branch ?? this.branch,
        radius: radius ?? this.radius);
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
