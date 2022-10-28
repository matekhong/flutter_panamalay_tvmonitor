// To parse this JSON data, do
//
//     final projectPartProgress = projectPartProgressFromJson(jsonString);

import 'dart:convert';

List<ProjectPartProgress> projectPartProgressFromJson(String str) =>
    List<ProjectPartProgress>.from(
        json.decode(str).map((x) => ProjectPartProgress.fromJson(x)));

String projectPartProgressToJson(List<ProjectPartProgress> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectPartProgress {
  ProjectPartProgress({
    required this.title,
    required this.subtitle1,
    required this.deadline,
    required this.planEnddate,
    required this.allSuryo,
    required this.compSuryo,
  });

  String title;
  String subtitle1;
  DateTime deadline;
  DateTime planEnddate;
  String allSuryo;
  String compSuryo;

  factory ProjectPartProgress.fromJson(Map<String, dynamic> json) =>
      ProjectPartProgress(
        title: json["title"],
        subtitle1: json["subtitle1"],
        deadline: DateTime.parse(json["deadline"] ?? ''),
        planEnddate: DateTime.parse(json["plan_enddate"] ?? ''),
        allSuryo: json["all_suryo"],
        compSuryo: json["comp_suryo"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle1": subtitle1,
        "deadline": deadline.toIso8601String(),
        "plan_enddate": planEnddate.toIso8601String(),
        "all_suryo": allSuryo,
        "comp_suryo": compSuryo,
      };
}
