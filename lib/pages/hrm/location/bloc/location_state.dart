part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationError extends LocationState {
  final String errorMessage;
  const LocationError({required this.errorMessage});
}

class LocationWaiting extends LocationState {}

class LocationSuccess extends LocationState {
  final List<LocationModel> locationList;
  const LocationSuccess({required this.locationList});
}

class LocationAddSuccess extends LocationState {
  final String mess;
  const LocationAddSuccess({required this.mess});
}

class LocationUpdateSuccess extends LocationState {
  final String message;
  const LocationUpdateSuccess({required this.message});
}

class LocationDeleteSuccess extends LocationState {
  final String message;
  const LocationDeleteSuccess({required this.message});
}
