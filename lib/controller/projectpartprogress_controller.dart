import 'package:flutter_panamaly_tvmonitor/model/projectpartprogress.dart';
import 'package:flutter_panamaly_tvmonitor/util/datastore.dart';
import 'package:get/state_manager.dart';

import '../service/database_service.dart';

class ProjectPartProgressController extends GetxController {
  var isLoading = true.obs;
  Rxn<List<ProjectPartProgress>> projectPartProgressList =
      Rxn<List<ProjectPartProgress>>([]);
  RxBool isShowDelay = true.obs;
  RxInt duration = 0.obs;
  RxDouble offset = 0.0.obs;
  RxString ip = ''.obs;
  @override
  void onInit() async {
    isShowDelay.value = await Datastore().getShowDelay();
    duration.value = await Datastore().getDuration();
    offset.value = await Datastore().getOffset();
    ip.value = await Datastore().getIP();
    fetchProjectPartProgress();
    super.onInit();
  }

  void fetchProjectPartProgress() async {
    try {
      isLoading(true);
      projectPartProgressList.value =
          await DatabaseService.fetchProjectPartProgress();
    } finally {
      isLoading(false);
    }
  }
}
