import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/config/constant.dart';
import 'package:erp/model/qc_master/manufacturing.dart';
import 'package:erp/pages/qc_master/tab1/check_list.dart';
import 'package:erp/reusable/cache_image_network.dart';
import 'package:erp/reusable/global_function.dart';
import 'package:erp/reusable/shimmer_loading.dart';

class TestPlanTab1 extends StatefulWidget {
  const TestPlanTab1({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TestPlanTab1State createState() => _TestPlanTab1State();
}

class _TestPlanTab1State extends State<TestPlanTab1>
    with SingleTickerProviderStateMixin {
  // initialize global function and global widget
  final _globalFunction = GlobalFunction();
  final _shimmerLoading = ShimmerLoading();
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  final Curve _curve = Curves.easeOut;
  bool _loading = true;
  Timer? _timerDummy;
  final Color _color1 = const Color(0xff777777);
  List<ManufacturingOrder> _manufacturingOrderData = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  TextEditingController _etSearch = TextEditingController();

  @override
  void initState() {
    _getData();
    _animationController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    _etSearch.dispose();
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  void _getData() {
    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerDummy = Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });

    _manufacturingOrderData = [
      ManufacturingOrder(
          rowpointer: "1",
          moNum: "MO2200000168",
          qty: 1234,
          qtyConsume: 12,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 1),
      ManufacturingOrder(
          rowpointer: "",
          moNum: "MO2200000169",
          qty: 121,
          qtyConsume: 54,
          desc: "Tạo từ bài bình abc",
          whse: "Kho sản xuất",
          status: 1),
      ManufacturingOrder(
          rowpointer: "3",
          moNum: "MO2200000170",
          qty: 8765,
          qtyConsume: 541,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 2),
      ManufacturingOrder(
          rowpointer: "4",
          moNum: "MO2200000171",
          qty: 764,
          qtyConsume: 54,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 2),
      ManufacturingOrder(
          rowpointer: "5",
          moNum: "MO2200000172",
          qty: 6754,
          qtyConsume: 75,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 3),
      ManufacturingOrder(
          rowpointer: "6",
          moNum: "MO2200000173",
          qty: 864,
          qtyConsume: 97,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 3),
      ManufacturingOrder(
          rowpointer: "7",
          moNum: "MO2200000174",
          qty: 6433,
          qtyConsume: 65,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 4),
      ManufacturingOrder(
          rowpointer: "8",
          moNum: "MO2200000175",
          qty: 9865,
          qtyConsume: 643,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 4),
      ManufacturingOrder(
          rowpointer: "9",
          moNum: "MO2200000176",
          qty: 8265,
          qtyConsume: 745,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 1),
      ManufacturingOrder(
          rowpointer: "10",
          moNum: "MO2200000177",
          qty: 3635,
          qtyConsume: 98,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 2)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    return Scaffold(
      
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            animate();
          },
          backgroundColor: _animateColor.value,
          child: AnimatedIcon(
            icon: AnimatedIcons.add_event,
            progress: _animateIcon,
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 5,
          backgroundColor: const Color(0xFF4AB35E),
          // create search text field in the app bar
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[100]!,
                      width: 1.0,
                    )),
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              height: kToolbarHeight,
              child: TextFormField(
                controller: _etSearch,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                onChanged: (textValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  suffixIcon: (_etSearch.text == '')
                      ? null
                      : GestureDetector(
                      onTap: () {
                        setState(() {
                          _etSearch = TextEditingController(text: '');
                        });
                      },
                      child: Icon(Icons.close, color: Colors.grey[500])),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey[200]!)),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: (_loading == true)
              ? _shimmerLoading.buildShimmerContent()
              : AnimatedList(
            key: _listKey,
            initialItemCount: _manufacturingOrderData.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index, animation) {
              return _buildItem(_manufacturingOrderData[index],
                  boxImageSize, animation, index);
            },
          ),
        ));
  }

  Widget _buildItem(
      ManufacturingOrder manufacturing, boxImageSize, animation, index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: manufacturing.status == 1
              ? Colors.lightBlue
              : manufacturing.status == 2
              ? Colors.grey
              : manufacturing.status == 3
              ? Colors.green
              : Colors.teal,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => CheckList()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: buildCacheNetworkImage(
                              width: boxImageSize,
                              height: boxImageSize,
                              url:
                              "https://intietkiem.com/wp-content/uploads/2020/06/giay-in-mau-duoc-su-dung-pho-bien-trong-in-an.jpg")),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              manufacturing.moNum,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                  'Qty: ${_globalFunction.removeDecimalZeroFormat(
                                          manufacturing.qty!)}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                  'Qty Loss: ${_globalFunction.removeDecimalZeroFormat(
                                          manufacturing.qtyConsume!)}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  // ignore: prefer_const_constructors
                                  Icon(Icons.location_on,
                                      color: SOFT_GREY, size: 12),
                                  Text(' ' + manufacturing.whse!,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future refreshData() async {
    setState(() {
      _manufacturingOrderData.clear();
      _loading = true;
      _getData();
    });
  }
}