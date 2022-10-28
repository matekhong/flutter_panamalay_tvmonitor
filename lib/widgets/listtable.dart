import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_panamaly_tvmonitor/util/utils.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../controller/projectpartprogress_controller.dart';
import '../model/projectpartprogress.dart';

class ListTable extends StatefulWidget {
  const ListTable({
    Key? key,
  }) : super(key: key);

  @override
  State<ListTable> createState() => _ListTableState();
}

class _ListTableState extends State<ListTable> {
  List<ProjectPartProgress> projectParts = <ProjectPartProgress>[];

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return GetX<ProjectPartProgressController>(
        builder: (projectPartProgressController) {
      startTimer(scrollController, projectPartProgressController.offset.value,
          projectPartProgressController.duration.value);
      final projectPartProgressList =
          projectPartProgressController.projectPartProgressList.value;
      return SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            for (var projectPartProgress in projectPartProgressList!)
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  dateFormat
                                      .format(projectPartProgress.deadline),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                if (projectPartProgress.deadline.isBefore(
                                        projectPartProgress.planEnddate) &&
                                    projectPartProgressController
                                        .isShowDelay.value) ...[
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'DELAY\n${dateFormat.format(projectPartProgress.planEnddate)}',
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 70,
                        width: 1,
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: 70,
                          color: const Color.fromARGB(255, 21, 46, 58),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        projectPartProgress.title,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        projectPartProgress.subtitle1,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${projectPartProgress.compSuryo} / ${projectPartProgress.allSuryo}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: CircularPercentIndicator(
                                  radius: 25.0,
                                  lineWidth: 3.0,
                                  percent: int.parse(
                                          projectPartProgress.compSuryo) /
                                      int.parse(projectPartProgress.allSuryo),
                                  center: Text(
                                    "${((int.parse(projectPartProgress.compSuryo) / int.parse(projectPartProgress.allSuryo)) * 100).ceil()}%",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  progressColor: projectPartProgress.deadline
                                              .isBefore(projectPartProgress
                                                  .planEnddate) &&
                                          projectPartProgressController
                                              .isShowDelay.value
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.white,
                  )
                ],
              )
          ],
        ),
      );
    });
  }

  void startTimer(
      ScrollController scrollController, double screenOffsets, int duration) {
    double curOfsets = 0;
    Timer.periodic(Duration(seconds: duration), (Timer t) {
      if (scrollController.hasClients) {
        if (screenOffsets == 0) {
          screenOffsets = screenOffsets;
        }
        if (scrollController.offset <
            scrollController.position.maxScrollExtent) {
          // Plus screen offset to current
          curOfsets += screenOffsets;
          // Jump to next offset
          scrollController.jumpTo(curOfsets);
        } else {
          // Case last scroll refresh data and go back to TOP
          scrollController.jumpTo(0);
          ProjectPartProgressController().fetchProjectPartProgress();
        }
      }
    });
  }
}
