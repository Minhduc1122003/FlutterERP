import 'package:flutter/material.dart';

import '../../config/constant.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
         Container(height: 10,color: Colors.white,),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            children: [
              buildAppbar(),
              buildInfor('TN', 'trung nguyen', 'Quản lý', '+84888888888'),
            ],
          ),
        ),
        const SizedBox(height: 15),
        buildAdvertisement(),
        const SizedBox(height: 15),
        buildActionItem(Icons.settings, 'Thiết lập quản lý'),
        buildActionItem(Icons.signal_cellular_alt_sharp, 'Báo cáo'),
        buildActionItem(Icons.date_range, 'Quản lý phép'),
        buildActionItem(Icons.description_rounded, 'Phiếu lương'),
        buildActionItem(Icons.settings_outlined, 'Quản lý KPI'),
        const SizedBox(height: 15),
        buildLanguage()
      ]),
    );
  }
}

Widget buildAppbar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.qr_code),
        ),
        const Text('Sửa', style: TextStyle(fontSize: 18)),
      ],
    ),
  );
}

Widget buildInfor(String acronym, String name, String position, String phone) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          acronym,
          style: const TextStyle(fontSize: 40, color: Colors.white),
        )),
      ),
      const SizedBox(height: 10),
      Text(name, style: const TextStyle(fontSize: 17)),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(position, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 10),
          //const Text('.',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
          Text(phone, style: const TextStyle(color: Colors.grey)),
        ],
      )
    ],
  );
}

Widget buildAdvertisement() {
  return Container(
    height: 150,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: mainColor, borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Nâng cấp tài khoản Tanca',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text('Miễn phí với 5 nhân viên',
                    style: TextStyle(fontSize: 12, color: Colors.white))
              ]),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/images/office.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildActionItem(IconData icon, String name) {
  return Container(
    height: 55,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(color: Colors.white),
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: mainColor,
        ),
        const SizedBox(width: 15),
        Text(name,style: TextStyle(fontSize: 17),),
        const Expanded(child: SizedBox.shrink()),
        Icon(
          Icons.arrow_forward_ios_outlined,
          size: 18,
          color: Colors.grey,
        )
      ],
    ),
  );
}

Widget buildLanguage() {
  return Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(color: Colors.white),
    child: Row(
      children: const [
        Icon(
          Icons.language,
          size: 20,
          color: Colors.blue,
        ),
        SizedBox(width: 15),
        Text('Ngôn ngữ'),
        Expanded(child: SizedBox.shrink()),
        Text(
          'Tiếng việt',
          style: TextStyle(color: Colors.grey),
        ),
        Icon(
          Icons.arrow_forward_ios_outlined,
          size: 18,
          color: Colors.grey,
        )
      ],
    ),
  );
}
