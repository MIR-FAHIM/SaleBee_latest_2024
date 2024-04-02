// To parse this JSON data, do
//
//     final followUpByProsIdModel = followUpByProsIdModelFromJson(jsonString);

import 'dart:convert';

FollowUpByProsIdModel followUpByProsIdModelFromJson(String str) => FollowUpByProsIdModel.fromJson(json.decode(str));

String followUpByProsIdModelToJson(FollowUpByProsIdModel data) => json.encode(data.toJson());

class FollowUpByProsIdModel {
  String message;
  ResultFollowUpByPros result;
  bool isSuccess;

  FollowUpByProsIdModel({
    required this.message,
    required this.result,
    required this.isSuccess,
  });

  factory FollowUpByProsIdModel.fromJson(Map<String, dynamic> json) => FollowUpByProsIdModel(
    message: json["Message"] ?? "No Data",
    result: ResultFollowUpByPros.fromJson(json["Result"]),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result.toJson(),
    "IsSuccess": isSuccess,
  };
}

class ResultFollowUpByPros {
  List<Call>? call;
  List<Call>? message;
  List<Call>? meeting;
  List<Call>? visit;
  List<Call>? others;
  List<Call>? email;
  List<Sm>? sms;
  List<Call>? file;

  ResultFollowUpByPros({
     this.call,
     this.message,
     this.meeting,
     this.visit,
     this.others,
     this.email,
     this.sms,
     this.file,
  });

  factory ResultFollowUpByPros.fromJson(Map<String, dynamic> json) => ResultFollowUpByPros(
    call: List<Call>.from(json["Call"].map((x) => Call.fromJson(x))),
    message: List<Call>.from(json["Message"].map((x) => x)),
    meeting: List<Call>.from(json["Meeting"].map((x) => Call.fromJson(x))),
    visit: List<Call>.from(json["Visit"].map((x) => Call.fromJson(x))),
    others: List<Call>.from(json["Others"].map((x) => Call.fromJson(x))),
    email: List<Call>.from(json["Email"].map((x) => x)),
    sms: List<Sm>.from(json["SMS"].map((x) => Sm.fromJson(x))),
    file: List<Call>.from(json["File"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Call": List<dynamic>.from(call!.map((x) => x.toJson())),
    "Message": List<dynamic>.from(message!.map((x) => x)),
    "Meeting": List<dynamic>.from(meeting!.map((x) => x.toJson())),
    "Visit": List<dynamic>.from(visit!.map((x) => x.toJson())),
    "Others": List<dynamic>.from(others!.map((x) => x.toJson())),
    "Email": List<dynamic>.from(email!.map((x) => x)),
    "SMS": List<dynamic>.from(sms!.map((x) => x.toJson())),
    "File": List<dynamic>.from(file!.map((x) => x)),
  };
}

class Call {
  String? title;
  String? description;
  DateTime date;

  Call({
    required this.title,
    required this.description,
    required this.date,
  });

  factory Call.fromJson(Map<String, dynamic> json) => Call(
    title: json["Title"]!,
    description: json["Description"],
    date: DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Description": description,
    "Date": date.toIso8601String(),
  };
}

enum Title {
  EMPTY
}

final titleValues = EnumValues({
  " ": Title.EMPTY
});

class Sm {
  int id;
  int prospectId;
  String mobileNo;
  String message;
  dynamic leadId;
  dynamic prospectFollowupSmsContactPersons;
  dynamic token;
  bool active;
  int createdBy;
  DateTime createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool isDeleted;

  Sm({
    required this.id,
    required this.prospectId,
    required this.mobileNo,
    required this.message,
    required this.leadId,
    required this.prospectFollowupSmsContactPersons,
    required this.token,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.isDeleted,
  });

  factory Sm.fromJson(Map<String, dynamic> json) => Sm(
    id: json["Id"],
    prospectId: json["ProspectId"],
    mobileNo: json["MobileNo"],
    message: json["Message"],
    leadId: json["LeadId"],
    prospectFollowupSmsContactPersons: json["ProspectFollowupSMSContactPersons"],
    token: json["Token"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProspectId": prospectId,
    "MobileNo": mobileNo,
    "Message": message,
    "LeadId": leadId,
    "ProspectFollowupSMSContactPersons": prospectFollowupSmsContactPersons,
    "Token": token,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
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
