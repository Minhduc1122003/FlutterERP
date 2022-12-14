import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:erp/pages/qc_master/tab1/content.dart';

class TestPlanPage extends StatefulWidget {
  const TestPlanPage({Key? key}) : super(key: key);

  @override
  State<TestPlanPage> createState() => _TestPlanPageState();
}

class _TestPlanPageState extends State<TestPlanPage> {
  Color color1 = const Color(0xFF4AB35E);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            toolbarHeight: 50,
            leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {}),
            title: const Text(
              'Kiểm tra',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: color1,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.cloud,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
            ],
            bottom: const PreferredSize(
              preferredSize: Size(50, 60),
              child: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: 'Kế hoạch', icon: Icon(Icons.pause)),
                  Tab(text: 'Trong tiến trình', icon: Icon(Icons.play_arrow)),
                  Tab(text: 'Báo cáo', icon: Icon(Icons.check)),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              TestPlanTab1(),
              TestPlanTab1(),
              Center(
                child: Text('Content 3'),
              ),
            ],
          )),
    );
  }
}
