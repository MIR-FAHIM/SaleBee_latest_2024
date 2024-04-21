// To parse this JSON data, do
//
//     final taskTypeModel = taskTypeModelFromJson(jsonString);

import 'dart:convert';

TaskTypeModel taskTypeModelFromJson(String str) => TaskTypeModel.fromJson(json.decode(str));

String taskTypeModelToJson(TaskTypeModel data) => json.encode(data.toJson());

class TaskTypeModel {
  String? message;
  List<ResultType>? result;
  bool? isSuccess;

  TaskTypeModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) => TaskTypeModel(
    message: json["Message"],
    result: List<ResultType>.from(json["Result"].map((x) => ResultType.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class ResultType {
  int id;
  String type;
  bool active;
  dynamic createdBy;
  dynamic createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool isDeleted;

  ResultType({
    required this.id,
    required this.type,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.isDeleted,
  });

  factory ResultType.fromJson(Map<String, dynamic> json) => ResultType(
    id: json["Id"],
    type: json["Type"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"],
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Type": type,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn,
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
  };
}
