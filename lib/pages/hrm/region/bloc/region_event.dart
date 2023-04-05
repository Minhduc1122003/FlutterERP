part of 'region_bloc.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();
  @override
  List<Object> get props => [];
}
class RegionLoadEvent extends RegionEvent {}
