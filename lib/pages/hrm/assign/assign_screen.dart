import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:get/get.dart';
import '../../../config/constant.dart';
import 'filter_assign_screen.dart';

class AssignScreen extends StatelessWidget {
  const AssignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              buildAppbar(),
              buildSearchBar(),
              const SizedBox(height: 10),
              listItem('Mới giao'),
              const SizedBox(height: 10),
              listItem('Hôm nay'),
              const SizedBox(height: 10),
              listItem('Sắp tới'),
              const SizedBox(height: 10),
              listItem('Chưa làm'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          heroTag: "btn",
          backgroundColor: mainColor,
          onPressed: () {
            // BottomDialog().showBottomDialog(context);
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              isScrollControlled: true,
              context: context,
              //useRootNavigator: false,
              builder: (BuildContext context) {
                return buildModalBottom(context);
              },
            );
          },
          child: const Icon(Icons.add, size: 25),
        ));
  }
}

Widget buildAppbar() {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text('TN', style: TextStyle(color: Colors.white)),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Giao việc', style: TextStyle(fontSize: 20)),
          Row(
            children: const [
              Text('Việc của tôi', style: TextStyle(color: Colors.grey)),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
      const Expanded(child: SizedBox.shrink()),
      const Icon(Icons.change_circle_outlined)
    ],
  );
}

Widget buildSearchBar() {
  return Row(
    children: [
      Icon(
        Icons.list_alt,
        color: mainColor,
        size: 30,
      ),
      const SizedBox(width: 10),
      const Icon(
        Icons.date_range_sharp,
        color: Colors.grey,
        size: 30,
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
          child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor.withOpacity(0.3)),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          cursorColor: backgroundColor,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
            ),
            //contentPadding: EdgeInsets.only(top: -17),
            contentPadding: EdgeInsets.zero,
            isCollapsed: true,
            hintText: 'Tên công việc...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      )),
      const SizedBox(
        width: 10,
      ),
      InkWell(
        onTap: () {
          Get.to(() => FilterAssignScreen());
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.tune),
        ),
      ),
    ],
  );
}

Widget listItem(String name) {
  return SizedBox(
    height: 40,
    child: Row(
      children: [
        const Icon(
          Icons.arrow_drop_down,
          size: 30,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 18),
        )
      ],
    ),
  );
}

Widget buildModalBottom(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    // height: 500,

    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //const SizedBox(height: 10),
          Container(
            height: 2,
            width: 50,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.lock,
                color: mainColor,
              ),
              const SizedBox(width: 5),
              Text('Việc của tôi',
                  style: TextStyle(color: Colors.grey[600], fontSize: 17)),
              const Expanded(child: SizedBox.shrink()),
              Text('Tạo', style: TextStyle(color: mainColor, fontSize: 17)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: Colors.grey[400]!),
            ),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Tên công việc',
                hintStyle: TextStyle(color: Colors.grey[400]!),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('TN', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              const Text('trung nguyen'),
              const Expanded(child: SizedBox.shrink()),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.date_range,
                  color: backgroundColor,
                ),
              ),
              const SizedBox(width: 10),
              const Text('Hạn chót', style: TextStyle(color: Colors.grey)),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Mô tả',
                  hintStyle: TextStyle(color: Colors.grey[400]!),
                ),
                keyboardType: TextInputType.multiline),
          ),
        ],
      ),
    ),
  );
}
