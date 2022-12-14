import 'dart:async';

import 'package:erp/pages/qc_master/infomation_unpost.dart';
import 'package:erp/pages/qc_master/unpost_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/config/constant.dart';
import 'package:erp/model/qc_master/manufacturing.dart';
import 'package:erp/reusable/cache_image_network.dart';
import 'package:erp/reusable/global_function.dart';
import 'package:erp/reusable/shimmer_loading.dart';

class UnpostMO extends StatefulWidget {
  const UnpostMO({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UnpostMOState createState() => _UnpostMOState();
}

class _UnpostMOState extends State<UnpostMO>
    with SingleTickerProviderStateMixin {
  // initialize global function and global widget
  final Color _color1 = const Color(0xff777777);
  final Color _color2 = const Color(0xFF515151);
  final _globalFunction = GlobalFunction();
  final _shimmerLoading = ShimmerLoading();
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  final Curve _curve = Curves.easeOut;
  bool _loading = true;
  Timer? _timerDummy;
  List<ManufacturingOrder> _manufacturingOrderData = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  TextEditingController _etSearch = TextEditingController();

  @override
  void initState() {
    _getData();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
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
          moNum: "MO2200000168_1",
          qty: 1234,
          qtyConsume: 12,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 1),
      ManufacturingOrder(
          rowpointer: "",
          moNum: "MO2200000168_2",
          qty: 121,
          qtyConsume: 54,
          desc: "Tạo từ bài bình abc",
          whse: "Kho sản xuất",
          status: 1),
      ManufacturingOrder(
          rowpointer: "3",
          moNum: "MO2200000168_3",
          qty: 8765,
          qtyConsume: 541,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 2),
      ManufacturingOrder(
          rowpointer: "4",
          moNum: "MO2200000168_4",
          qty: 764,
          qtyConsume: 54,
          desc: "Create from MO Builder",
          whse: "Kho sản xuất",
          status: 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const UnpostNewPage()));
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
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
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const InfomationUnpostPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: buildCacheNetworkImage(
                              width: boxImageSize,
                              height: boxImageSize,
                              url:
                                  "https://intietkiem.com/wp-content/uploads/2020/06/giay-in-mau-duoc-su-dung-pho-bien-trong-in-an.jpg")),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              manufacturing.moNum,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: _color2,
                                  fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                  'Qty: ${_globalFunction.removeDecimalZeroFormat(manufacturing.qty!)}',
                                  style:
                                      TextStyle(fontSize: 15, color: _color1)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                  'Qty Loss: ${_globalFunction.removeDecimalZeroFormat(manufacturing.qtyConsume!)}',
                                  style:
                                      TextStyle(fontSize: 15, color: _color1)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  // ignore: prefer_const_constructors
                                  Icon(Icons.location_on,
                                      color: SOFT_GREY, size: 12),
                                  Text(' ${manufacturing.whse}',
                                      style: TextStyle(
                                          fontSize: 15, color: _color1))
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
