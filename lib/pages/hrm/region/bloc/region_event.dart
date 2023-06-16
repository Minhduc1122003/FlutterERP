part of 'region_bloc.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();
  @override
  List<Object> get props => [];
}
class RegionLoadEvent extends RegionEvent {}

class GetRegionEvent extends RegionEvent {
    final String site;
    final String token;
  const GetRegionEvent({required this.site, required this.token});
}

class AddRegionEvent extends RegionEvent {
  final int id;
  final String site;
  final String name;
  final String description;
  final String token;
  const AddRegionEvent(
      {required this.id,
      required this.site,
      required this.name,
      required this.description,
      required this.token});
}
