import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_panamaly_tvmonitor/widgets/listheader.dart';
import 'package:flutter_panamaly_tvmonitor/widgets/listtable.dart';
import 'package:flutter_panamaly_tvmonitor/widgets/windowbuttons.dart';

import '../util/utils.dart';

class ProjectProgressTable extends StatefulWidget {
  const ProjectProgressTable({Key? key}) : super(key: key);

  @override
  State<ProjectProgressTable> createState() => _ProjectProgressTableState();
}

class _ProjectProgressTableState extends State<ProjectProgressTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: [0.0, 1.0]),
        ),
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          ),
          // Screen Header
          const ListHeader(),
          // Column Header
          Container(
            height: 30,
            color: Colors.white,
            child: Row(
              children: const [
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'DATE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: Text(
                      'PROJECT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'PROGRESS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
          const Expanded(child: ListTable()),
        ]),
      ),
    );
  }
}
