import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/constant.dart';

class RequestManagementScreen extends StatelessWidget {
  const RequestManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Quản lý yêu cầu',
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            actions: [
              InkWell(
                child: const Icon(Icons.tune),
                onTap: () {},
              ),
              const SizedBox(width: 20),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(Icons.checklist_rounded),
                ),
                onTap: () {},
              )
            ],
          ),
          body: Column(
            children: [
              buildFromDayToDay(DateTime(2022, 11, 4), DateTime(2022, 12, 4)),
              const SizedBox(height: 10),
              buildTabar([], [], []),
              buildTabarView([], [], [])
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            heroTag: "btn",
            backgroundColor: mainColor,
            onPressed: () {},
            child: const Icon(Icons.add, size: 25),
          )),
    );
  }
}

Widget buildFromDayToDay(DateTime fromDay, DateTime toDay) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 50),
    color: Colors.white,
    child: Row(
      children: [
        Text(
          '${DateFormat('dd.MM').format(fromDay)} - ${DateFormat('dd.MM').format(toDay)}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[600],
        )
      ],
    ),
  );
}

Widget buildTabar(List<String> requestList, List<String> acceptanceList,
    List<String> refuseList) {
  return SizedBox(
    height: 30,
    child: TabBar(

        //labelColor: appColor,
        //unselectedLabelColor: Colors.white,
        labelColor: mainColor,
        indicatorColor: mainColor,
        //isScrollable: true,
        unselectedLabelColor: Colors.grey[400],
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        // indicator: BoxDecoration(
        //color: Colors.white,
        //color: appColor,
        //  borderRadius: BorderRadius.circular(5)),
        tabs: [
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Yêu cầu', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '${requestList.length}',
                    style: const TextStyle(color: Colors.orange),
                  )),
                )
              ],
            ),
          )),
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chấp thuận', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '${acceptanceList.length}',
                    style: const TextStyle(color: Colors.blue),
                  )),
                )
              ],
            ),
          )),
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Từ chối', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '${refuseList.length}',
                    style: const TextStyle(color: Colors.red),
                  )),
                )
              ],
            ),
          )),
        ]),
  );
}

Widget buildTabarView(
    List<String> request, List<String> acceptance, List<String> refuse) {
  return Expanded(
      child: Container(
          color: mainColor.withOpacity(0.15),
          child: const TabBarView(children: [
            Center(
                child: Text('Chưa có yêu cầu nào',
                    style: TextStyle(fontSize: 18))),
            Center(
                child: Text('Chưa có chấp thuận nào',
                    style: TextStyle(fontSize: 18))),
            Center(
                child:
                    Text('Chưa có từ chối nào', style: TextStyle(fontSize: 18)))
          ])));
}
