import 'package:erp/config/constant.dart';
import 'package:erp/pages/qc_master/tab1/pick_image.dart';
import 'package:erp/pages/qc_master/tab1/unpost_mo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UnpostNewPage extends StatefulWidget {
  const UnpostNewPage({super.key});

  @override
  State<UnpostNewPage> createState() => _UnpostNewPageState();
}

class _UnpostNewPageState extends State<UnpostNewPage> {
  String? _valRouting;

  final List _routingList = [
    "Cutting",
    "Assembly",
    "Sanding",
    "Finishing",
    "Packing",
    "Final",
  ];

  var androidVersions = [
    "All material parts match product specification",
    "Check cutting dimension based on drawing",
    "Check dead knots, crack, bowing",
    "Check drilling hole as drawing (use jig to compare)",
    "Moisture check",
    "Quantity check"
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF4AB35E),
        middle: Text(
          'New Unpost',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.green, spreadRadius: 1),
                ],
              ),
              child: const Center(
                child: Text('MO2200000176',
                    style: TextStyle(
                        color: BLACK55,
                        fontWeight: FontWeight.w600,
                        fontSize: 20)),
              )),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            // ignore: prefer_const_constructors
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text("Select Routing"),
              value: _valRouting,
              items: _routingList.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _valRouting = value!;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: _textField(TextInputType.number, "Qty"),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: _textField(TextInputType.number, "Qty OK"))),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: _textField(TextInputType.number, "Qty Loss"))),
            ],
          ),
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
              color: mainColor,
              onPressed: () {
                () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const UnpostMO()));
                };
              },
              child: const Text('Complete'),
            ),
          ),
        ]),
      ),
    );
  }

  TextField _textField(TextInputType textInputType, String label) {
    return TextField(
        keyboardType: textInputType,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: label));
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
                        builder: (context) => const PickImagePage()));
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
