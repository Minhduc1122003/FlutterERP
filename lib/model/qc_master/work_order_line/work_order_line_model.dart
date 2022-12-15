// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WorkOrderLineModel {
  String? site;
  String? woLineNum;
  String? woNum;
  dynamic qtyOK;
  dynamic qtyNG;
  int? status;
  WorkOrderLineModel({
    this.site,
    this.woLineNum,
    this.woNum,
    required this.qtyOK,
    required this.qtyNG,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'site': site,
      'woLineNum': woLineNum,
      'woNum': woNum,
      'qtyOK': qtyOK,
      'qtyNG': qtyNG,
      'status': status,
    };
  }

  factory WorkOrderLineModel.fromMap(Map<String, dynamic> map) {
    return WorkOrderLineModel(
      site: map['site'] != null ? map['site'] as String : null,
      woLineNum: map['woLineNum'] != null ? map['woLineNum'] as String : null,
      woNum: map['woNum'] != null ? map['woNum'] as String : null,
      qtyOK: map['qtyOK'] as dynamic,
      qtyNG: map['qtyNG'] as dynamic,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkOrderLineModel.fromJson(String source) => WorkOrderLineModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
