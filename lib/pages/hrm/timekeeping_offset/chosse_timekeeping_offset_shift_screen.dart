import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../hrm_model/shift_model.dart';
import 'bloc/timekeeping_offset_bloc.dart';


class ChosseTimekeepingOffsetShiftScreen extends StatelessWidget {
  const ChosseTimekeepingOffsetShiftScreen(
      {Key? key, required this.listShiftModel})
      : super(key: key);
  final List<ShiftModel> listShiftModel;

  @override
  Widget build(BuildContext context) {
    // TimekeepingOffsetController controller =
    //     Get.find<TimekeepingOffsetController>();
    // controller.checkListShiftModel();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 0,
        title: const Text(
          'Chọn',
          style: TextStyle(color: blueBlack),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: listShiftModel.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildChooseItem(
                  context, index, listShiftModel[index].name, (int id) {
                BlocProvider.of<TimekeepingOffsetBloc>(context)
                    .add(ChoosseShiftEvent(shiftModel: listShiftModel[id]));
              });
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Colors.grey[200])),
      ),
    );
  }
}

Widget _buildChooseItem(
    BuildContext context, int id, String name, Function(int) selected) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      selected(id);
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
        capitalize(name),
        style: const TextStyle(fontSize: 17, color: blueBlack),
      ),
    ),
  );
}
