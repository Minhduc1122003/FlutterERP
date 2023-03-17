import 'package:flutter/material.dart';


import '../../config/hrm_constant.dart';
import '../../model/visit_today_model.dart';
import 'visit_screen.dart';

class VisitTodayScreen extends StatelessWidget {
  const VisitTodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<VisitTodayModel> listVisitTodayModel = [
      VisitTodayModel(
          id: 1,
          name: 'Ho Kinh Doanh Dai Phuc Thinh',
          address: 'Kios 3- so 742 luy ban bich tan thanh',
          phone: '0985 758 371',
          line: 'Tuyến T3 / W4'),
      VisitTodayModel(
          id: 2,
          name: 'Cty TNHH SX - TM - DV DAI HONG AN',
          address: '125-127 go dau phuopng tan quy',
          phone: '0854 559 441',
          line: 'Tuyến T3 / W4'),
      VisitTodayModel(
          id: 3,
          name: 'Cty TNHH TM-DV-XD Nha dep',
          address: '125-127 go dau phuopng tan quy',
          phone: '0854 559 441',
          line: 'Tuyến T3 / W4')
    ];
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF005288),
        title: const Text('Viếng thăm hôm nay'),
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {},
        // ),
        actions: [
        //   IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {},
        // ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        color: Colors.blueGrey[40],
        child: ListView.separated(
          separatorBuilder: (context, position) {
            return const SizedBox(height: 7);
          },
          itemCount: listVisitTodayModel.length,
          itemBuilder: (context, int index) {
            return _buildVisitTodayItem(context ,listVisitTodayModel[index]);
          },
        ),
      ),
    );
  }
}
 Widget _buildDrawer(BuildContext context) {
    return Drawer(

        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        // const UserAccountsDrawerHeader(
        //   accountName: Text("DSR73575540002"),
        //   accountEmail: Text("LE MINH TRIEU"),
        //   currentAccountPicture: CircleAvatar(
        //     backgroundColor: Colors.white,
        //     child: Text("A", style: TextStyle(fontSize: 40.0)),
        //   ),
        // ),
        Container(
          color: const Color(0xFF005288),
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: Column(children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(GLOBAL_URL + '/user/avatar.png'),
            ),
            SizedBox(height: 10),
            Text(
              'DSR73575540002',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              'LE MINH TRIEU',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ]),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'Dashboard',
            style: TextStyle(fontSize: 17),
          ),
          //trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Thông tin cá nhân', style: TextStyle(fontSize: 17)),
          //leading: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text('Viếng thăm hôm nay', style: TextStyle(fontSize: 17)),
          onTap: () {
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const VisitTodayScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.check_sharp),
          title: Text('Khách hàng đã thăm hôm nay',
              style: TextStyle(fontSize: 17)),
          onTap: () {
             Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Thoát', style: TextStyle(fontSize: 17)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }

Widget _buildVisitTodayItem(BuildContext context, VisitTodayModel model) {
  return Card(
    margin: EdgeInsets.all(0),
    // decoration: BoxDecoration(
    //   color: Colors.white,
    //   borderRadius: BorderRadius.circular(5),
    //   boxShadow: [
    //     BoxShadow(color: Colors.white, offset: Offset(-3, -3), blurRadius: 1),
    //     BoxShadow(color: Colors.grey[300]!, offset: Offset(3, 3), blurRadius: 1)
    //   ],
    // ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 80,
          child: Column(
            children:const [
              SizedBox(height: 10),
              Icon(
                Icons.store,
                color: Colors.grey,
              ),
            ],
          )),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                    child: Text(
                  model.name.toUpperCase(),
                  style:const TextStyle(fontSize: 20),
                )),
                IconButton(
                    onPressed: () {},
                    icon:const Icon(Icons.keyboard_arrow_right_sharp,
                        color: Colors.grey))
              ],
            ),
            const SizedBox(height: 5),
            Text(
              model.address.toUpperCase(),
              style:const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              model.phone,
              style:const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              model.line,
              style:const TextStyle(fontSize: 20),
            ),
            ElevatedButton(onPressed: () {
                         Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  VisitScreen(visitTodayModel: model,)));
            }, child:const Text('Kế hoạch',style: TextStyle(fontSize: 18),))
          ],
        ),
      )
    ]),
  );
  
}


