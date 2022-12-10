class ManufacturingOrder {
  late String rowpointer;
  late String moNum;
  double? qty;
  double? qtyConsume;
  String? desc;
  late String whse;
  late int status;

  ManufacturingOrder(
      {required this.rowpointer,
      required this.moNum,
      required this.qty,
      required this.qtyConsume,
      required this.desc,
      required this.whse,
      required this.status});
}
