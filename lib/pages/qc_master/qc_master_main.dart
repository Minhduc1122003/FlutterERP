import 'package:erp/model/qc_master/work_order/bloc/work_order_bloc.dart';
import 'package:erp/model/qc_master/work_order_line/bloc/work_order_line_bloc.dart';
import 'package:erp/pages/qc_master/test_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QCMaster extends StatelessWidget {
  const QCMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WorkOrderBloc>(
          create: (BuildContext context) => WorkOrderBloc(),
        ),
        BlocProvider<WorkOrderLineBloc>(
          create: (BuildContext context) => WorkOrderLineBloc(),
        ),
      ],
      child: const TestPlanPage(),
    );
  }
}
