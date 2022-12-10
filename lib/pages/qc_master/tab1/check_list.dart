import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/config/constant.dart';
import 'package:erp/model/banner_slider_model.dart';
import 'package:erp/pages/qc_master/tab1/check_list_detal.dart';
import 'package:erp/reusable/cache_image_network.dart';

class CheckList extends StatefulWidget {
  const CheckList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  // initialize global widget
  final List<BannerSliderModel> _bannerData = [];

  var androidVersions = [
    "Cutting",
    "Assembly",
    "Sanding",
    "Finising",
    "Packing",
    "Final"
  ];

  @override
  void initState() {
    _bannerData.add(
        BannerSliderModel(id: 1, image: '$GLOBAL_URL/category_banner/1.jpg'));
    _bannerData.add(
        BannerSliderModel(id: 2, image: '$GLOBAL_URL/category_banner/2.jpg'));
    _bannerData.add(
        BannerSliderModel(id: 3, image: '$GLOBAL_URL/category_banner/3.jpg'));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CupertinoNavigationBar(
          backgroundColor: Color(0xFF4AB35E),
          middle: Text('CheckList'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: CarouselSlider(
                    items: _bannerData
                        .map((item) => Container(
                              child: buildCacheNetworkImage(
                                  width: 0, height: 0, url: item.image),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        scrollDirection: Axis.vertical,
                        aspectRatio: 2,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 6),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 300),
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {});
                        }),
                  )),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 16),
                itemBuilder: (context, index) {
                  return _buildItem(index);
                },
                itemCount: androidVersions.length,
              ),
            ],
          ),
        ));
  }

  Widget _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => CheckListDetail()));
      },
      child: Card(
        child: Container(
          height: 50,
          child: Row(
            children: [
              Container(
                width: 5,
                height: 50,
                color: Colors.red,
              ),
              const Icon(Icons.lock_reset_rounded, color: Colors.red, size: 26),
              const SizedBox(width: 24),
              Expanded(
                child: Text(androidVersions[index],
                    style: const TextStyle(
                        fontSize: 16,
                        color: BLACK55,
                        fontWeight: FontWeight.w500)),
              ),
              const Icon(Icons.chevron_right, size: 30, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}