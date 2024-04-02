// To parse this JSON data, do
//
//     final getLeaddModel = getLeaddModelFromJson(jsonString);

import 'dart:convert';

GetLeaddModel getLeaddModelFromJson(String str) => GetLeaddModel.fromJson(json.decode(str));

String getLeaddModelToJson(GetLeaddModel data) => json.encode(data.toJson());

class GetLeaddModel {
  String message;
  List<ResultLead> result;
  bool isSuccess;

  GetLeaddModel({
    required this.message,
    required this.result,
    required this.isSuccess,
  });

  factory GetLeaddModel.fromJson(Map<String, dynamic> json) => GetLeaddModel(
    message: json["Message"],
    result: List<ResultLead>.from(json["Result"].map((x) => ResultLead.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class ResultLead {
  int leadId;
  DateTime createdDate;
  int assignedTo;
  String leadName;
  int prospectId;
  List<Item> items;
  List<ConcernPerson> concernPerson;
  double? estimatedClosingAmount;
  DateTime estimatedClosingDate;
  String? priority;
  int? stageId;
  String? stageName;
  DateTime stageDate;
  List<LastFollowup> lastFollowup;
  int? createdBy;
  String? createdByName;

  ResultLead({
    required this.leadId,
    required this.createdDate,
    required this.assignedTo,
    required this.leadName,
    required this.prospectId,
    required this.items,
    required this.concernPerson,
    required this.estimatedClosingAmount,
    required this.estimatedClosingDate,
    required this.priority,
    required this.stageId,
    required this.stageName,
    required this.stageDate,
    required this.lastFollowup,
    required this.createdBy,
    required this.createdByName
  });

  factory ResultLead.fromJson(Map<String, dynamic> json) => ResultLead(
    leadId: json["LeadId"],
    createdDate: DateTime.parse(json["CreatedDate"]),
    assignedTo: json["AssignedTo"],
    leadName: json["LeadName"],
    prospectId: json["ProspectId"],
    items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
    concernPerson: List<ConcernPerson>.from(json["ConcernPerson"].map((x) => ConcernPerson.fromJson(x))),
    estimatedClosingAmount: json["EstimatedClosingAmount"],
    estimatedClosingDate: DateTime.parse(json["EstimatedClosingDate"]),
    priority:json["Priority"] ?? "High",
    stageId: json["StageId"],
    stageName: json["StageName"] ?? "New",
    stageDate: DateTime.parse(json["StageDate"]),
    lastFollowup: List<LastFollowup>.from(json["LastFollowup"].map((x) => LastFollowup.fromJson(x))),
    createdBy: json["CreatedBy"],
    createdByName: json['CreatedByName']
  );

  Map<String, dynamic> toJson() => {
    "LeadId": leadId,
    "CreatedDate": createdDate.toIso8601String(),
    "AssignedTo": assignedTo,
    "LeadName": leadName,
    "ProspectId": prospectId,
    "Items": List<dynamic>.from(items.map((x) => x.toJson())),
    "ConcernPerson": List<dynamic>.from(concernPerson.map((x) => x.toJson())),
    "EstimatedClosingAmount": estimatedClosingAmount,
    "EstimatedClosingDate": estimatedClosingDate.toIso8601String(),
    "Priority": priorityValues.reverse[priority],
    "StageId": stageId,
    "StageName": stageNameValues.reverse[stageName],
    "StageDate": stageDate.toIso8601String(),
    "LastFollowup": List<dynamic>.from(lastFollowup.map((x) => x.toJson())),
    "CreatedBy": createdBy,
    'CreatedByName': createdByName,
  };
}

class ConcernPerson {
  String? name;
  String? designation;
  String? mobile;

  ConcernPerson({
    required this.name,
    required this.designation,
    required this.mobile,
  });

  factory ConcernPerson.fromJson(Map<String, dynamic> json) => ConcernPerson(
    name: json["Name"],
    designation: json["Designation"],
    mobile: json["Mobile"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Designation": designation,
    "Mobile": mobile,
  };
}

class Item {
  int itemId;

  Item({
    required this.itemId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["ItemId"],
  );

  Map<String, dynamic> toJson() => {
    "ItemId": itemId,
  };
}

class LastFollowup {
  int personId;
  int followupType;
  DateTime date;

  LastFollowup({
    required this.personId,
    required this.followupType,
    required this.date,
  });

  factory LastFollowup.fromJson(Map<String, dynamic> json) => LastFollowup(
    personId: json["PersonId"],
    followupType: json["FollowupType"],
    date: DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "PersonId": personId,
    "FollowupType": followupType,
    "Date": date.toIso8601String(),
  };
}

enum Priority {
  HIGH,
  LOW,
  NORMAL,
  VERY_HIGH,
  VERY_LOW
}

final priorityValues = EnumValues({
  "High": Priority.HIGH,
  "Low": Priority.LOW,
  "Normal": Priority.NORMAL,
  "Very High": Priority.VERY_HIGH,
  "Very Low": Priority.VERY_LOW
});

enum StageName {
  DEMO,
  FOLLOWUP,
  FREE_TRIAL,
  LEAD_LOST,
  LEAD_WON,
  MEETING,
  NEGOTIATIONS,
  NEW_LEAD,
  QUOTATION,
  READY_TO_BUY
}

final stageNameValues = EnumValues({
  "Demo": StageName.DEMO,
  "Followup": StageName.FOLLOWUP,
  "Free Trial ": StageName.FREE_TRIAL,
  "Lead Lost": StageName.LEAD_LOST,
  "Lead Won": StageName.LEAD_WON,
  "Meeting": StageName.MEETING,
  "Negotiations": StageName.NEGOTIATIONS,
  "New Lead": StageName.NEW_LEAD,
  "Quotation": StageName.QUOTATION,
  "Ready to Buy": StageName.READY_TO_BUY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
