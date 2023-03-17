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
  BranchModel branch;
  LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.branch,
  });
  LocationModel copyWith(
      {int? id, String? name, String? address, BranchModel? branch}) {
    return LocationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        branch: branch ?? this.branch);
  }
}
