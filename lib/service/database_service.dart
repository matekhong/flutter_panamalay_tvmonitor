import 'package:flutter_panamaly_tvmonitor/model/projectpartprogress.dart';
import 'package:flutter_panamaly_tvmonitor/util/datastore.dart';
import 'package:http/http.dart' as http;

class DatabaseService {
  static var client = http.Client();

  static Future<List<ProjectPartProgress>> fetchProjectPartProgress() async {
    var serverIP = await Datastore().getIP();
    var response = await client
        .get(Uri.parse('https://$serverIP/doctor/api/projectpartprogress'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return projectPartProgressFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }
}
