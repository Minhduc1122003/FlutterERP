class WorkOrder {
  late String woNum;
  late String imgUrl;
  late double? qtyOK;
  late double? qtyNG;
  late String whse;
  late String operation;

  WorkOrder(
      {required this.woNum,
      required this.imgUrl,
      required this.qtyOK,
      required this.qtyNG,
      required this.whse,
      required this.operation});
}
