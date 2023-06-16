part of 'branch_bloc.dart';

abstract class BranchEvent extends Equatable {
  const BranchEvent();
  @override
  List<Object> get props => [];
}
class BranchLoadEvent extends BranchEvent {}

class GetBranchEvent extends BranchEvent {
    final String site;
    final String token;
  const GetBranchEvent({required this.site, required this.token});
}

class AddBranchEvent extends BranchEvent {
  final int id;
  final int idArea;
  final String site;
  final String name;
  final String description;
  final String token;
  const AddBranchEvent(
      {required this.id,
      required this.idArea,
      required this.site,
      required this.name,
      required this.description,
      required this.token});
}