import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import '../../../config/constant.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../kpi_screen.dart';
import '../management_setting_screen.dart';
import '../on_leave_screen.dart';
import '../report_screen.dart';
import '../salary/salary_caculate_screen.dart';
import '../warning_setting_screen.dart';
import 'edit_account_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 10,
          color: Colors.white,
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            children: [
              _buildAppbar(context),
              const SizedBox(height: 10),
              buildInfor('trung nguyen', 'Quản lý', '+84888888888'),
            ],
          ),
        ),
        const SizedBox(height: 15),
        // buildAdvertisement(),
        //const SizedBox(height: 15),
        _buildActionItem(
            context, 1, Icons.settings, mainColor, 'Thiết lập quản lý'),
        _buildActionItem(
            context, 2, Icons.signal_cellular_alt_sharp, mainColor, 'Báo cáo'),
        _buildActionItem(
            context, 3, Icons.date_range, mainColor, 'Quản lý phép'),
        _buildActionItem(
            context, 4, Icons.description_rounded, mainColor, 'Phiếu lương'),
        _buildActionItem(context, 5, Entypo.trophy, mainColor, 'Quản lý KPI'),
        const SizedBox(height: 15),
        buildLanguage(),
        _buildActionItem(
            context, 6, Icons.notifications, Colors.blue, 'Cài đặt cảnh báo '),
        _buildActionItem(context, 7, Icons.business_center_outlined,
            Colors.blue, 'Đổi doanh nghiệp'),

        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red, width: 1),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                //Get.back();
              },
              child: Text('Đăng xuất',
                  style: TextStyle(color: Colors.red, fontSize: 22)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}

Widget _buildAppbar(BuildContext context) {
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
        InkWell(
            child: const Text('Sửa',
                style: TextStyle(fontSize: 18, color: blueBlack)),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditAccountScreen()))),
      ],
    ),
  );
}

Widget buildInfor(String name, String position, String phone) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(
          acronymName(name),
          style: const TextStyle(fontSize: 40, color: Colors.white),
        )),
      ),
      const SizedBox(height: 10),
      Text(name, style: const TextStyle(fontSize: 17, color: blueBlack)),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(position, style: const TextStyle(color: backgroundColor)),
          const SizedBox(width: 10),
          //const Text('.',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
          Text(phone, style: const TextStyle(color: backgroundColor)),
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

Widget _buildActionItem(
    BuildContext context, int id, IconData icon, Color color, String name) {
  return InkWell(
    onTap: () {
      if (id == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ManagementSettingScreen()));
      } else if (id == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReportScreen()));
      } else if (id == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OnLeaveScreen()));
      } else if (id == 4) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SalaryCaculateScreen()));
      } else if (id == 5) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KPIScreen()));
      } else if (id == 6) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WarningSettingScreen()));
      }
    },
    child: Container(
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
            color: color,
          ),
          const SizedBox(width: 15),
          Text(
            name,
            style: TextStyle(fontSize: 17),
          ),
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18,
              color: Colors.grey,
            ),
          )
        ],
      ),
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
