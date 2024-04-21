// To parse this JSON data, do
//
//     final newTaskListModel = newTaskListModelFromJson(jsonString);

import 'dart:convert';

NewTaskListModel newTaskListModelFromJson(String str) => NewTaskListModel.fromJson(json.decode(str));

String newTaskListModelToJson(NewTaskListModel data) => json.encode(data.toJson());

class NewTaskListModel {
  String? message;
  ResultTask? result;
  bool? isSuccess;

  NewTaskListModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory NewTaskListModel.fromJson(Map<String, dynamic> json) => NewTaskListModel(
    message: json["Message"],
    result: ResultTask.fromJson(json["Result"]),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result!.toJson(),
    "IsSuccess": isSuccess,
  };
}

class ResultTask {
  int total;
  int page;
  int itemsPerPage;
  List<DatumTask> data;
  List<StatusCount> statusCount;

  ResultTask({
    required this.total,
    required this.page,
    required this.itemsPerPage,
    required this.data,
    required this.statusCount,
  });

  factory ResultTask.fromJson(Map<String, dynamic> json) => ResultTask(
    total: json["total"],
    page: json["page"],
    itemsPerPage: json["itemsPerPage"],
    data: List<DatumTask>.from(json["data"].map((x) => DatumTask.fromJson(x))),
    statusCount: List<StatusCount>.from(json["statusCount"].map((x) => StatusCount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "itemsPerPage": itemsPerPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "statusCount": List<dynamic>.from(statusCount.map((x) => x.toJson())),
  };
}

class DatumTask {
  int taskId;
  DateTime createdOn;
  int createdBy;
  String title;
  int assignedTo;
  String assignedPerson;
  String taskDesc;
  int statusId;
  DateTime dueDate;
  int type;
  String taskType;
  String allStatus;
  String priorityName;
  int priority;
  String prospectName;
  int prospectId;
  bool? prospectStatus;
  bool? isIndividual;
  String prospectNumber;
  DateTime? statusUpdateDate;
  int leadId;
  String leadName;
  int doneOrder;
  List<ContactPersonDetail> contactPersonDetails;
  dynamic contactPersonDetailsJson;
  String taskShares;
  bool canDelete;
  int overDueOrder;
  String isProspectActive;
  String createdByName;
  List<dynamic> taskFiles;

  DatumTask({
    required this.taskId,
    required this.createdOn,
    required this.createdBy,
    required this.title,
    required this.assignedTo,
    required this.assignedPerson,
    required this.taskDesc,
    required this.statusId,
    required this.dueDate,
    required this.type,
    required this.taskType,
    required this.allStatus,
    required this.priorityName,
    required this.priority,
    required this.prospectName,
    required this.prospectId,
    required this.prospectStatus,
    required this.isIndividual,
    required this.prospectNumber,
    required this.statusUpdateDate,
    required this.leadId,
    required this.leadName,
    required this.doneOrder,
    required this.contactPersonDetails,
    required this.contactPersonDetailsJson,
    required this.taskShares,
    required this.canDelete,
    required this.overDueOrder,
    required this.isProspectActive,
    required this.createdByName,
    required this.taskFiles,
  });

  factory DatumTask.fromJson(Map<String, dynamic> json) => DatumTask(
    taskId: json["TaskID"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
    title: json["Title"],
    assignedTo: json["AssignedTo"],
    assignedPerson:json["AssignedPerson"]!,
    taskDesc: json["TaskDesc"],
    statusId: json["StatusId"],
    dueDate: DateTime.parse(json["DueDate"]),
    type: json["Type"],
    taskType: json["TaskType"]!,
    allStatus: json["AllStatus"],
    priorityName: json["PriorityName"]!,
    priority: json["Priority"],
    prospectName:json["ProspectName"]!,
    prospectId: json["ProspectId"],
    prospectStatus: json["ProspectStatus"],
    isIndividual: json["IsIndividual"],
    prospectNumber: json["ProspectNumber"],
    statusUpdateDate: json["StatusUpdateDate"] == null ? null : DateTime.parse(json["StatusUpdateDate"]),
    leadId: json["LeadId"],
    leadName: json["LeadName"]!,
    doneOrder: json["DoneOrder"],
    contactPersonDetails: json["ContactPersonDetails"] == null ? [] : List<ContactPersonDetail>.from(json["ContactPersonDetails"]!.map((x) => ContactPersonDetail.fromJson(x))),

    contactPersonDetailsJson: json["ContactPersonDetailsJSON"],
    taskShares: json["TaskShares"],
    canDelete: json["CanDelete"],
    overDueOrder: json["OverDueOrder"],
    isProspectActive: json["IsProspectActive"]!,
    createdByName: json["CreatedByName"]!,
    taskFiles: List<dynamic>.from(json["TaskFiles"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "CreatedOn": createdOn.toIso8601String(),
    "CreatedBy": createdBy,
    "Title": title,
    "AssignedTo": assignedTo,
    "AssignedPerson": assignedPerson,
    "TaskDesc": taskDesc,
    "StatusId": statusId,
    "DueDate": dueDate.toIso8601String(),
    "Type": type,
    "TaskType":taskType,
    "AllStatus": allStatus,
    "PriorityName":priorityName,
    "Priority": priority,
    "ProspectName": prospectName,
    "ProspectId": prospectId,
    "ProspectStatus": prospectStatus,
    "IsIndividual": isIndividual,
    "ProspectNumber": prospectNumber,
    "StatusUpdateDate": statusUpdateDate?.toIso8601String(),
    "LeadId": leadId,
    "LeadName": leadName,
    "DoneOrder": doneOrder,
    "ContactPersonDetails": contactPersonDetails == null ? [] : List<dynamic>.from(contactPersonDetails!.map((x) => x.toJson())),
    "ContactPersonDetailsJSON": contactPersonDetailsJson,
    "TaskShares": taskShares,
    "CanDelete": canDelete,
    "OverDueOrder": overDueOrder,
    "IsProspectActive": isProspectActive,
    "CreatedByName": createdByName,
    "TaskFiles": List<dynamic>.from(taskFiles.map((x) => x)),
  };
}

class ContactPersonDetail {
  String contactpersonName;
  String contactpersonDesignation;
  dynamic contactpersonDesignationId;
  String contactpersonMobile;
  String contactpersonEmail;
  bool isPrimary;

  ContactPersonDetail({
    required this.contactpersonName,
    required this.contactpersonDesignation,
    required this.contactpersonDesignationId,
    required this.contactpersonMobile,
    required this.contactpersonEmail,
    required this.isPrimary,
  });

  factory ContactPersonDetail.fromJson(Map<String, dynamic> json) => ContactPersonDetail(
    contactpersonName: json["ContactpersonName"] ?? "No Data",
    contactpersonDesignation: json["ContactpersonDesignation"]?? "No Data",
    contactpersonDesignationId: json["ContactpersonDesignationId"]?? "No Data",
    contactpersonMobile: json["ContactpersonMobile"]?? "No Data",
    contactpersonEmail: json["ContactpersonEmail"]?? "No Data",
    isPrimary: json["IsPrimary"],
  );

  Map<String, dynamic> toJson() => {
    "ContactpersonName": contactpersonName,
    "ContactpersonDesignation": contactpersonDesignation,
    "ContactpersonDesignationId": contactpersonDesignationId,
    "ContactpersonMobile": contactpersonMobile,
    "ContactpersonEmail": contactpersonEmail,
    "IsPrimary": isPrimary,
  };
}

class StatusCount {
  int statusId;
  String statusName;
  int taskCount;
  bool isSelected;

  StatusCount({
    required this.statusId,
    required this.statusName,
    required this.taskCount,
    required this.isSelected,
  });

  factory StatusCount.fromJson(Map<String, dynamic> json) => StatusCount(
    statusId: json["StatusId"],
    statusName: json["StatusName"],
    taskCount: json["TaskCount"],
    isSelected: json["IsSelected"],
  );

  Map<String, dynamic> toJson() => {
    "StatusId": statusId,
    "StatusName": statusName,
    "TaskCount": taskCount,
    "IsSelected": isSelected,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
