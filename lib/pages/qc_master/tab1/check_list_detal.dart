import 'package:erp/pages/qc_master/tab1/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:erp/config/constant.dart';
import 'package:erp/pages/qc_master/tab1/check_list.dart';
import 'package:erp/pages/qc_master/tab1/pick_image.dart';

class CheckListDetail extends StatefulWidget {
  const CheckListDetail({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckListDetailState createState() => _CheckListDetailState();
}

class _CheckListDetailState extends State<CheckListDetail> {
  // initialize global widget
  final Color _bulletColor = const Color(0xff01aed6);

  var androidVersions = [
    "All material parts match product specification",
    "Check cutting dimension based on drawing",
    "Check dead knots, crack, bowing",
    "Check drilling hole as drawing (use jig to compare)",
    "Moisture check",
    "Quantity check"
  ];

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CupertinoNavigationBar(
          backgroundColor: Color(0xFF4AB35E),
          middle: Text('CheckListDetail'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoButton(
                  color: Colors.teal,
                  onPressed: () {
                    () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const CheckList()));
                    };
                  },
                  child: const Text('Complete'),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildItem(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          // All actions are defined in the children parameter.
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: const Color(0xFF4AB35E),
              foregroundColor: Colors.white,
              icon: Icons.done,
              label: 'Complete',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const TestPage()));
              },
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Archive',
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const PickImagePage()));
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: CupertinoIcons.clear_circled_solid,
              label: 'Error',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Icon(Icons.lock_reset_rounded, color: Colors.red, size: 26),
              const SizedBox(width: 24),
              Expanded(
                child: Text(androidVersions[index],
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        fontSize: 16,
                        color: BLACK55,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
