// To parse this JSON data, do
//
//     final taskStatusModel = taskStatusModelFromJson(jsonString);

import 'dart:convert';

TaskStatusModel taskStatusModelFromJson(String str) =>
    TaskStatusModel.fromJson(json.decode(str));

String taskStatusModelToJson(TaskStatusModel data) =>
    json.encode(data.toJson());

class TaskStatusModel {
  String? message;
  List<ResultSta>? result;
  bool? isSuccess;

  TaskStatusModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  factory TaskStatusModel.fromJson(Map<String, dynamic> json) =>
      TaskStatusModel(
        message: json["Message"],
        result: List<ResultSta>.from(
            json["Result"].map((x) => ResultSta.fromJson(x))),
        isSuccess: json["IsSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "IsSuccess": isSuccess,
      };
}

class ResultSta {
  int id;
  String name;
  String? statusColor;
  int? order;
  bool? isFixed;
  bool active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  bool isDeleted;

  ResultSta({
    required this.id,
    required this.name,
    required this.statusColor,
    required this.order,
    required this.isFixed,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.isDeleted,
  });

  factory ResultSta.fromJson(Map<String, dynamic> json) => ResultSta(
        id: json["ID"],
        name: json["Name"],
        statusColor: json["StatusColor"],
        order: json["Order"],
        isFixed: json["IsFixed"],
        active: json["Active"],
        createdBy: json["CreatedBy"],
        createdOn: json["CreatedOn"] == null
            ? null
            : DateTime.parse(json["CreatedOn"]),
        updatedBy: json["UpdatedBy"],
        updatedOn: json["UpdatedOn"] == null
            ? null
            : DateTime.parse(json["UpdatedOn"]),
        isDeleted: json["IsDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "StatusColor": statusColor,
        "Order": order,
        "IsFixed": isFixed,
        "Active": active,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn?.toIso8601String(),
        "UpdatedBy": updatedBy,
        "UpdatedOn": updatedOn?.toIso8601String(),
        "IsDeleted": isDeleted,
      };
}
