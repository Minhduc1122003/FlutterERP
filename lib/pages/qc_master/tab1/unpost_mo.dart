// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/model/qc_master/work_order_line/bloc/work_order_line_bloc.dart';
import 'package:erp/model/qc_master/work_order_line/work_order_line_model.dart';
import 'package:erp/pages/qc_master/infomation_unpost.dart';
import 'package:erp/pages/qc_master/unpost_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/config/constant.dart';
import 'package:erp/reusable/cache_image_network.dart';
import 'package:erp/reusable/global_function.dart';
import 'package:erp/reusable/shimmer_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UnpostMO extends StatefulWidget {
  const UnpostMO({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UnpostMOState createState() => _UnpostMOState();
}

class _UnpostMOState extends State<UnpostMO>
    with SingleTickerProviderStateMixin {
  // initialize global function and global widget
  late WorkOrderLineBloc _workOrderLineBloc;
  
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  TextEditingController _etSearch = TextEditingController();
  List<WorkOrderLineModel> _workOrderLineModel = [];
  
  CancelToken apiToken = CancelToken();

  @override
  void initState() {
    _workOrderLineBloc = BlocProvider.of<WorkOrderLineBloc>(context);
    
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
    _workOrderLineBloc.add(WorkOrderLine("KATA", "WO0000000001", apiToken));
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
        body: BlocListener<WorkOrderLineBloc, WorkOrderLineState>(
          listener: (context, state) {
            if (state is GetError) {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: state.errorMessage,
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 13);
            }
            if (state is GetWaiting) {
              FocusScope.of(context).unfocus();
              _globalFunction.showProgressDialog(context);
            }
            if (state is GetSuccess) {
              Navigator.pop(context);
              _workOrderLineModel.addAll(state.data);
              setState(() {
                _loading = false;
              });
            }
          },
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: (_loading == true)
                ? _shimmerLoading.buildShimmerContent()
                : AnimatedList(
                    key: _listKey,
                    initialItemCount: _workOrderLineModel.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index, animation) {
                      return _buildItem(_workOrderLineModel[index],
                          boxImageSize, animation, index);
                    },
                  ),
          ),
        ));
  }

  Widget _buildItem(
      WorkOrderLineModel workOrderLineModel, boxImageSize, animation, index) {
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
                            builder: (context) =>
                                const InfomationUnpostPage()));
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
                              workOrderLineModel.woLineNum!,
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
                                  'Qty: ${_globalFunction.removeDecimalZeroFormat(workOrderLineModel.qtyOK!)}',
                                  style:
                                      TextStyle(fontSize: 15, color: _color1)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                  'Qty Loss: ${_globalFunction.removeDecimalZeroFormat(workOrderLineModel.qtyNG!)}',
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
                                  Text(' ${workOrderLineModel.woNum}',
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
      _workOrderLineModel.clear();
      _loading = true;
      _getData();
    });
  }
}
