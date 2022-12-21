import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../../config/constant.dart';
import 'hrm_method.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              children: [
                buildAppbar('trung nguyen', 'Giám đốc'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Lịch làm việc',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                ),
                const SizedBox(height: 15),
                buildDay(),
                const SizedBox(height: 15),
                buildVaoCa()
              ],
            ),
          ),
          const SizedBox(height: 15),
          buildManipulation(),
          const SizedBox(height: 15),
          buildFolder(),
          buildCheckWork(),
        ],
      ),
    );
  }
}

Widget buildAppbar(String name, String position) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey[200],
            borderRadius: BorderRadius.circular(15)),
        height: 50,
        width: 50,
        child: const Center(
            child: Text(
          'TN',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      const SizedBox(width: 10),
      SizedBox(
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(position)
          ],
        ),
      ),
      const Expanded(child: SizedBox.shrink()),
      Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.notifications_none_outlined,
            size: 25,
          ))
    ],
  );
}

Widget buildDay() {
  DateTime now = DateTime.now();
  int day = now.day;
// DateTime now=DateTime.utc(2022, 12, 9);
  int firstDayOfWeek = now.weekday;
  // DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday-1));
  //DateFormat('EEEE').format(now);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      for (int i = 0; i < 7; i++)
        (now.subtract(Duration(days: firstDayOfWeek - 1 - i)).day != day)
            ? Container(
                width: 40,
                //height: 60,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(232, 251, 236, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        getDay(i + 1),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                     // const SizedBox(height: 5),
                      Text(
                        now
                            .subtract(Duration(days: firstDayOfWeek - 1 - i))
                            .day
                            .toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Container(
                       height: 4,
                       width: 4, 
                       decoration: BoxDecoration(color: Colors.grey,shape: BoxShape.circle),
                      ),
                      const SizedBox(height: 5),
                    ]),
              )
            : Container(
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: mainColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        getDay(i + 1),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      //const SizedBox(height: 5),
                      Text(
                        now
                            .subtract(Duration(days: firstDayOfWeek - 1 - i))
                            .day
                            .toString(),
                        style: TextStyle(fontSize: 16, color: mainColor),
                      ),
                      const SizedBox(height: 5),
                       Container(
                       height: 4,
                       width: 4, 
                       decoration: BoxDecoration(color: Colors.grey,shape: BoxShape.circle),
                      ),
                      const SizedBox(height: 5),
                    ]),
              )
    ],
  );
}



Widget buildVaoCa() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    //height: 80,
    width: double.infinity,
    decoration: BoxDecoration(
        color: mainColor, borderRadius: BorderRadius.circular(15)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Vào ca',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Text(
            '23:31',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: const Icon(
          //Icons.wifi_tethering,size: 30,
          IconData(0xe287, fontFamily: 'MaterialIcons'), size: 30,
        ),
      )
    ]),
  );
}

Widget buildManipulation() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Đã hoàn thành 1/5',
          style: TextStyle(fontSize: 23),
        ),
        const SizedBox(height: 10),
        Text(
          'Hoàn thành các thao tác bên dưới để nhận thêm ngày trải nghiệm miễn phí Tanca.',
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
        ),
        const SizedBox(height: 15),
        buildManipulationItem(Icons.person_add_alt, 'Thêm nhân viên mới', 1),
        const SizedBox(height: 15),
        buildManipulationItem(FontAwesome.calendar_plus_o, 'Tạo ca làm', 2),
        const SizedBox(height: 15),
        buildManipulationItem(
            Icons.description_outlined, 'Duyệt một yêu cầu công việc', 2),
        const SizedBox(height: 15),
        buildManipulationItem(Icons.date_range_outlined, 'Đặt lịch Demo', 2)
      ]),
    ),
  );
}

Widget buildManipulationItem(IconData icon, String name, int day) {
  return Row(
    children: [
      Container(
        height: 40,
        width: 30,
        decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
      const SizedBox(width: 15),
      Text(
        name,
      ),
      const Expanded(child: SizedBox.shrink()),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: mainColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          '+$day ngày',
          style: TextStyle(color: mainColor),
        ),
      ),
    ],
  );
}

Widget buildFolder() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thư mục',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            buildFolderItem('Yêu cầu', Colors.amber, Icons.beenhere),
            const SizedBox(width: 15),
            buildFolderItem('Chấm công', Colors.blue, Icons.repeat),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            buildFolderItem('Ứng lương', Colors.green[300]!, Icons.monetization_on_outlined),
            const SizedBox(width: 15),
            buildFolderItem('Xếp ca', Colors.deepOrange, Icons.apps),
          ],
        ),
      ],
    ),
  );
}

Widget buildFolderItem(String name, Color color, IconData icon) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              //color: Colors.yellowAccent[700],
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  color.withOpacity(0.3),
                  color,
                ],
              )),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 10),
        Text(name)
      ]),
    ),
  );
}

Widget buildCheckWork() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Ai đang làm việc?',
              style: TextStyle(fontSize: 20),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            buildCheckWorkItem(0, 'Đã vào', Colors.black),
            const SizedBox(width: 15),
            buildCheckWorkItem(0, 'Đi muộn', Colors.orange),
            const SizedBox(width: 15),
            buildCheckWorkItem(0, 'Đúng giờ', Colors.green),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            buildCheckWorkItem(0, 'Chưa vào', Colors.red),
            const SizedBox(width: 15),
            buildCheckWorkItem(0, 'Nghỉ phép', Colors.purple),
            const SizedBox(width: 15),
            buildCheckWorkItem(0, 'Chia sẻ vị trí', Colors.yellow),
          ],
        ),
      ],
    ),
  );
}

Widget buildCheckWorkItem(int amount, String name, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: 90,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Text(
          '$amount',
          style: TextStyle(
              fontSize: 18, color: color, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(name)
      ]),
    ),
  );
}
