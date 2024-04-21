// To parse this JSON data, do
//
//     final followUpModel = followUpModelFromJson(jsonString);

import 'dart:convert';

FollowUpModel followUpModelFromJson(String str) => FollowUpModel.fromJson(json.decode(str));

String followUpModelToJson(FollowUpModel data) => json.encode(data.toJson());

class FollowUpModel {
  String? message;
  Result? result;
  bool? isSuccess;

  FollowUpModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory FollowUpModel.fromJson(Map<String, dynamic> json) => FollowUpModel(
    message: json["Message"],
    result: Result.fromJson(json["Result"]),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result!.toJson(),
    "IsSuccess": isSuccess,
  };
}

class Result {
  int total;
  int page;
  int itemsPerPage;
  List<FollowUpData> data;

  Result({
    required this.total,
    required this.page,
    required this.itemsPerPage,
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    total: json["total"],
    page: json["page"],
    itemsPerPage: json["itemsPerPage"],
    data: List<FollowUpData>.from(json["data"].map((x) => FollowUpData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "itemsPerPage": itemsPerPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FollowUpData {
  int id;
  int prospectId;
  String prospectName;
  String prospectStage;
  DateTime prospectStageDate;
  int leadId;
  String leadName;
  String leadStage;
  bool prospectStatus;
  String title;
  String description;
  String type;
  String stringType;
  int employeeId;
  int assignToEmployeeId;
  String assignToEmployeeName;
  DateTime createdOn;
  String createdBy;
  bool canDelete;
  List<ProspectFollowupNoteContactPerson> prospectFollowupNoteContactPersons;

  FollowUpData({
    required this.id,
    required this.prospectId,
    required this.prospectName,
    required this.prospectStage,
    required this.prospectStageDate,
    required this.leadId,
    required this.leadName,
    required this.leadStage,
    required this.prospectStatus,
    required this.title,
    required this.description,
    required this.type,
    required this.stringType,
    required this.employeeId,
    required this.assignToEmployeeId,
    required this.assignToEmployeeName,
    required this.createdOn,
    required this.createdBy,
    required this.canDelete,
    required this.prospectFollowupNoteContactPersons,
  });

  factory FollowUpData.fromJson(Map<String, dynamic> json) => FollowUpData(
    id: json["Id"],
    prospectId: json["ProspectId"],
    prospectName: json["ProspectName"]!,
    prospectStage: json["ProspectStage"]!,
    prospectStageDate: DateTime.parse(json["ProspectStageDate"]),
    leadId: json["LeadId"],
    leadName: json["LeadName"] ?? "No Data",
    leadStage: json["LeadStage"] ?? "No Data",
    prospectStatus: json["ProspectStatus"],
    title: json["Title"]!,
    description: json["Description"],
    type: json["Type"],
    stringType: json["stringType"]!,
    employeeId: json["EmployeeId"],
    assignToEmployeeId: json["AssignToEmployeeId"],
    assignToEmployeeName: json["AssignToEmployeeName"]!,
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"]!,
    canDelete: json["CanDelete"],
    prospectFollowupNoteContactPersons: List<ProspectFollowupNoteContactPerson>.from(json["ProspectFollowupNoteContactPersons"].map((x) => ProspectFollowupNoteContactPerson.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProspectId": prospectId,
    "ProspectName": prospectName,
    "ProspectStage": prospectStage,
    "ProspectStageDate": prospectStageDate.toIso8601String(),
    "LeadId": leadId,
    "LeadName": leadName,
    "LeadStage": leadStage,
    "ProspectStatus": prospectStatus,
    "Title":title,
    "Description": description,
    "Type": type,
    "stringType": stringType,
    "EmployeeId": employeeId,
    "AssignToEmployeeId": assignToEmployeeId,
    "AssignToEmployeeName":assignToEmployeeName,
    "CreatedOn": createdOn.toIso8601String(),
    "CreatedBy": createdBy,
    "CanDelete": canDelete,
    "ProspectFollowupNoteContactPersons": List<dynamic>.from(prospectFollowupNoteContactPersons.map((x) => x.toJson())),
  };
}

class ProspectFollowupNoteContactPerson {
  String name;
  String designationName;
  String email;
  String contactNo;

  ProspectFollowupNoteContactPerson({
    required this.name,
    required this.designationName,
    required this.email,
    required this.contactNo,
  });

  factory ProspectFollowupNoteContactPerson.fromJson(Map<String, dynamic> json) => ProspectFollowupNoteContactPerson(
    name: json["Name"]!,
    designationName: json["DesignationName"] ?? "No Data",
    email: json["Email"] ?? "No Data",
    contactNo: json["ContactNo"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "DesignationName": designationName,
    "Email":email,
    "ContactNo": contactNo,
  };
}

