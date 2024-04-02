// To parse this JSON data, do
//
//     final prospectStatusModel = prospectStatusModelFromJson(jsonString);

import 'dart:convert';

ProspectStatusModel prospectStatusModelFromJson(String str) => ProspectStatusModel.fromJson(json.decode(str));

String prospectStatusModelToJson(ProspectStatusModel data) => json.encode(data.toJson());

class ProspectStatusModel {
  String message;
  List<ResultStatus> result;
  bool isSuccess;

  ProspectStatusModel({
    required this.message,
    required this.result,
    required this.isSuccess,
  });

  factory ProspectStatusModel.fromJson(Map<String, dynamic> json) => ProspectStatusModel(
    message: json["Message"],
    result: List<ResultStatus>.from(json["Result"].map((x) => ResultStatus.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class ResultStatus {
  int id;
  String status;
  String funnelColor;
  int funnelOrder;
  bool? isFixed;
  bool active;
  int createdBy;
  String createdOn;
  int? updatedBy;
  DateTime? updatedOn;

  ResultStatus({
    required this.id,
    required this.status,
    required this.funnelColor,
    required this.funnelOrder,
    required this.isFixed,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
  });

  factory ResultStatus.fromJson(Map<String, dynamic> json) => ResultStatus(
    id: json["ID"],
    status: json["Status"],
    funnelColor: json["FunnelColor"],
    funnelOrder: json["FunnelOrder"],
    isFixed: json["IsFixed"],
    active: json["Active"],
    createdBy: json["CreatedBy"]?? 0,
    createdOn: json["CreatedOn"] ?? DateTime.now().toString(),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Status": status,
    "FunnelColor": funnelColor,
    "FunnelOrder": funnelOrder,
    "IsFixed": isFixed,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn,
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn?.toIso8601String(),
  };
}
