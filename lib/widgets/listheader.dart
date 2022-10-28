import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_panamaly_tvmonitor/controller/projectpartprogress_controller.dart';
import 'package:flutter_panamaly_tvmonitor/util/datastore.dart';
import 'package:flutter_panamaly_tvmonitor/util/utils.dart';
import 'package:get/get.dart';

class ListHeader extends StatefulWidget {
  const ListHeader({Key? key}) : super(key: key);

  @override
  State<ListHeader> createState() => _ListHeaderState();
}

class _ListHeaderState extends State<ListHeader> {
  @override
  Widget build(BuildContext context) {
    final ProjectPartProgressController projectController = Get.find();
    TextEditingController durationController = TextEditingController(
        text: projectController.duration.value.toString());
    TextEditingController offsetController =
        TextEditingController(text: projectController.offset.value.toString());
    TextEditingController ipController =
        TextEditingController(text: projectController.ip.value);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'PROGRESS',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return SizedBox(
                                height: 200,
                                width: 200,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text('Server IP : ')),
                                        Expanded(
                                          flex: 3,
                                          child: TextFormField(
                                            controller: ipController,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text('Duration : ')),
                                        Expanded(
                                          flex: 3,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: durationController,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 2, child: Text('Offset : ')),
                                        Expanded(
                                          flex: 3,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: offsetController,
                                            textAlign: TextAlign.right,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text('Show Delay : ')),
                                        Expanded(
                                          flex: 3,
                                          child: Switch(
                                            value: projectController
                                                .isShowDelay.value,
                                            onChanged: (value) {
                                              Datastore().setShowDelay(value);
                                              setState(() {
                                                projectController
                                                    .isShowDelay.value = value;
                                              });
                                            },
                                            activeTrackColor: Colors.red[100],
                                            activeColor: Colors.red[300],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Save"),
                                onPressed: () {
                                  projectController.duration.value =
                                      int.parse(durationController.text);
                                  projectController.offset.value =
                                      double.parse(offsetController.text);
                                  projectController.ip.value =
                                      ipController.text;
                                  // Save to memory
                                  Datastore().setDuration(
                                      int.parse(durationController.text));
                                  Datastore().setOffset(
                                      double.parse(offsetController.text));
                                  Datastore().setIP(ipController.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      dateHeaderFormal.format(DateTime.now()),
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
