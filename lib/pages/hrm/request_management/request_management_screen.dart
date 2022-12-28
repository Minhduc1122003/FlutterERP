import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../config/constant.dart';
import 'choose_request_screen.dart';
import '../color.dart';
import '../hrm_model/request_management_model.dart';
import '../on_leave/new_on_leave_screen.dart';
import 'filter_request_screen.dart';
import 'request_management_controller.dart';

class RequestManagementScreen extends StatelessWidget {
  const RequestManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RequestManagementController controller =
        Get.put(RequestManagementController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Quản lý yêu cầu',
              style: TextStyle(color: blueBlack),
            ),
            iconTheme: const IconThemeData(color: blueBlack),
            elevation: 0,
            actions: [
              InkWell(
                child: const Icon(Icons.tune),
                onTap: () => Get.to(() => FilterRequestScreen()),
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
              Obx(() => buildFromDayToDay(
                    context,
                    controller.startDate.value,
                    controller.endDate.value,
                    (PickerDateRange pickerDateRange) =>
                        controller.setDateRange(pickerDateRange),
                  )),
              const SizedBox(height: 10),
              buildTabar([], [], []),
              buildTabarView([], [], [])
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            heroTag: "btn",
            backgroundColor: mainColor,
            onPressed: () {
              if (controller.requestManagementKind.value.id == 1) {
                Get.to(() => const ChooseRequestScreen());
              }
            },
            child: const Icon(Icons.add, size: 25),
          )),
    );
  }
}

Widget buildFromDayToDay(BuildContext context, DateTime fromDay, DateTime toDay,
    Function(PickerDateRange) changedDateRange) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 50),
    child: InkWell(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SfDateRangePicker(
                        headerStyle: const DateRangePickerHeaderStyle(
                            backgroundColor: Colors.blue,
                            textAlign: TextAlign.center,
                            textStyle:
                                TextStyle(fontSize: 22, color: Colors.white)),
                        headerHeight: 50,
                        view: DateRangePickerView.month,
                        showActionButtons: true,
                        selectionMode:
                            DateRangePickerSelectionMode.extendableRange,
                        onSubmit: (Object? value) {
                          Navigator.pop(context);
                          if (value == null) return;
                          changedDateRange(value as PickerDateRange);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              '${DateFormat('dd.MM').format(fromDay)} - ${DateFormat('dd.MM').format(toDay)}',
              style: const TextStyle(fontSize: 16, color: blueGrey1)),
          const Icon(Icons.arrow_drop_down, color: blueGrey1, size: 30)
        ],
      ),
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
        unselectedLabelColor: blueGrey3,
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
                Text('Yêu cầu', style: TextStyle(fontSize: 16)),
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
                    style: TextStyle(color: Colors.orange),
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
                Text('Chấp thuận', style: TextStyle(fontSize: 16)),
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
                    style: TextStyle(color: Colors.blue),
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
                Text('Từ chối', style: TextStyle(fontSize: 16)),
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
                    style: TextStyle(color: Colors.red),
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
