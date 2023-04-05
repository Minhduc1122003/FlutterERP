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
