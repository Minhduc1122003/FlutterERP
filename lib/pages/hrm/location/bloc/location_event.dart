part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationLoadEvent extends LocationEvent {}

class GetLocationEvent extends LocationEvent {
  final String site;
  final String token;
  const GetLocationEvent({required this.site, required this.token});
}

class LocationAddEVent extends LocationEvent {
  final int id;
  final int branchID;
  final String site;
  final String name;
  final String address;
  final String longitude;
  final String latitude;
  final int radius;

  final String token;
  const LocationAddEVent(
      {required this.id,
      required this.branchID,
      required this.site,
      required this.name,
      required this.address,
      required this.longitude,
      required this.latitude,
      required this.radius,
      required this.token});
}

class LocationUpdateEvent extends LocationEvent {
  final int id;
  final int branchID;
  final String site;
  final String name;
  final String address;
  final String longitude;
  final String latitude;
  final int radius; // Thêm tham số radius
  final String token;

  const LocationUpdateEvent({
    required this.id,
    required this.branchID,
    required this.site,
    required this.name,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.radius, // Thêm tham số radius
    required this.token,
  });
}

class LocationDeleteEvent extends LocationEvent {
  final int id; // ID của vị trí cần xóa
  final String token; // Token xác thực

  const LocationDeleteEvent({
    required this.id,
    required this.token,
  });
}
