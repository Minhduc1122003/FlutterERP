import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WorkOrderModel {
  String? woNum;
  String? itemNo;
  String? imgUrl;
  dynamic qty;
  dynamic qtyOK;
  dynamic qtyNG;
  int? stats;
  DateTime? deadLine;
  WorkOrderModel({
    this.woNum,
    this.itemNo,
    this.imgUrl,
    this.qty,
    this.qtyOK,
    this.qtyNG,
    this.stats,
    this.deadLine,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'woNum': woNum,
      'itemNo': itemNo,
      'urlImg': imgUrl,
      'qty': qty,
      'qtyOK': qtyOK,
      'qtyNG': qtyNG,
      'stats': stats,
      'deadLine': deadLine?.millisecondsSinceEpoch,
    };
  }

  factory WorkOrderModel.fromMap(Map<String, dynamic> map) {
    return WorkOrderModel(
      woNum: map['woNum'] != null ? map['woNum'] as String : null,
      itemNo: map['itemNo'] != null ? map['itemNo'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      qty: map['qty'] as dynamic,
      qtyOK: map['qtyOK'] as dynamic,
      qtyNG: map['qtyNG'] as dynamic,
      stats: map['stats'] != null ? map['stats'] as int : null,
      deadLine: map['deadLine'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deadLine'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkOrderModel.fromJson(String source) =>
      WorkOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
