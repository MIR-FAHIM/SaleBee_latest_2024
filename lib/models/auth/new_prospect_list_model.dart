// To parse this JSON data, do
//
//     final prospectListModel = prospectListModelFromJson(jsonString);

import 'dart:convert';

ProspectNewListModel prospectListModelFromJson(String str) => ProspectNewListModel.fromJson(json.decode(str));

String prospectListModelToJson(ProspectNewListModel data) => json.encode(data.toJson());

class ProspectNewListModel {
  String? message;
  Result? result;
  bool? isSuccess;

  ProspectNewListModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory ProspectNewListModel.fromJson(Map<String, dynamic> json) => ProspectNewListModel(
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
  List<StageCount> stageCount;
  List<ProspectList> prospects;

  Result({
    required this.stageCount,
    required this.prospects,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    stageCount: List<StageCount>.from(json["StageCount"].map((x) => StageCount.fromJson(x))),
    prospects: List<ProspectList>.from(json["Prospects"].map((x) => ProspectList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "StageCount": List<dynamic>.from(stageCount.map((x) => x.toJson())),
    "Prospects": List<dynamic>.from(prospects.map((x) => x.toJson())),
  };
}

class ProspectList {
  int id;
  String name;
  String? code;
  String? smsType;
  String? contactNumber;
  int? designationId;
  String? designationName;
  String? email;
  List<ConcernPerson>? concernPersons;
  String? concernPersonsJson;
  DateTime? dateOfBirth;
  DateTime createdOn;
  bool isIndividual;
  dynamic type;
  int leadCount;
  int quoteCount;
  int orderCount;
  int taskCount;
  int followupCallCount;
  int followupEmailCount;
  int followupMeetingCount;
  int followupVisitCount;
  DateTime? lastFlwDate;
  String? lastFlwBy;
  String? websiteProspect;
  String? createdByName;
  int createdBy;
  int? assignToEmployeeId;
  String? assignToEmployee;
  int? zoneId;
  String? zoneName;
  int? connectedBy;
  int? industryTypeId;
  String? industryType;
  int? informationSourceId;
  int? jobType;
  int? organizationTypeId;
  int? campaignId;
  int? priority;
  dynamic isPrimary;
  String? interestedItems;
  double? latitude;
  double? longitude;
  int? prospectStage;
  String? stage;
  DateTime? prospectStageDate;
  DateTime changeDate;
  String? note;
  dynamic prospectIds;
  int totalCount;
  int projectId;
  bool canEdit;
  bool canDelete;
  bool canView;

  ProspectList({
    required this.id,
    required this.name,
    required this.code,
    required this.smsType,
    required this.contactNumber,
    required this.designationId,
    required this.designationName,
    required this.email,
    required this.concernPersons,
    required this.concernPersonsJson,
    required this.dateOfBirth,
    required this.createdOn,
    required this.isIndividual,
    required this.type,
    required this.leadCount,
    required this.quoteCount,
    required this.orderCount,
    required this.taskCount,
    required this.followupCallCount,
    required this.followupEmailCount,
    required this.followupMeetingCount,
    required this.followupVisitCount,
    required this.lastFlwDate,
    required this.lastFlwBy,
    required this.websiteProspect,
    required this.createdByName,
    required this.createdBy,
    required this.assignToEmployeeId,
    required this.assignToEmployee,
    required this.zoneId,
    required this.zoneName,
    required this.connectedBy,
    required this.industryTypeId,
    required this.industryType,
    required this.informationSourceId,
    required this.jobType,
    required this.organizationTypeId,
    required this.campaignId,
    required this.priority,
    required this.isPrimary,
    required this.interestedItems,
    required this.latitude,
    required this.longitude,
    required this.prospectStage,
    required this.stage,
    required this.prospectStageDate,
    required this.changeDate,
    required this.note,
    required this.prospectIds,
    required this.totalCount,
    required this.projectId,
    required this.canEdit,
    required this.canDelete,
    required this.canView,
  });

  factory ProspectList.fromJson(Map<String, dynamic> json) => ProspectList(
    id: json["Id"],
    name: json["Name"],
    code: json["Code"],
    smsType: json["smsType"],
    contactNumber: json["ContactNumber"],
    designationId: json["DesignationId"],
    designationName: json["DesignationName"],
    email: json["Email"],
    concernPersons: json["ConcernPersons"] == null ? [] : List<ConcernPerson>.from(json["ConcernPersons"]!.map((x) => ConcernPerson.fromJson(x))),
    concernPersonsJson: json["ConcernPersonsJSON"],
    dateOfBirth: json["DateOfBirth"] == null ? null : DateTime.parse(json["DateOfBirth"]),
    createdOn: DateTime.parse(json["CreatedOn"]),
    isIndividual: json["IsIndividual"],
    type: json["Type"],
    leadCount: json["LeadCount"],
    quoteCount: json["QuoteCount"],
    orderCount: json["OrderCount"],
    taskCount: json["TaskCount"],
    followupCallCount: json["Followup_CallCount"],
    followupEmailCount: json["Followup_EmailCount"],
    followupMeetingCount: json["Followup_MeetingCount"],
    followupVisitCount: json["Followup_VisitCount"],
    lastFlwDate: json["LastFlwDate"] == null ? null : DateTime.parse(json["LastFlwDate"]),
    lastFlwBy: json["LastFlwBy"],
    websiteProspect: json["WebsiteProspect"]?? "No data",
    createdByName: json["CreatedByName"]?? "No data",
    createdBy: json["CreatedBy"],
    assignToEmployeeId: json["AssignToEmployeeId"],
    assignToEmployee: json["AssignToEmployee"]?? "No data",
    zoneId: json["ZoneID"]?? 0,
    zoneName: json["ZoneName"] ?? "No data",
    connectedBy: json["ConnectedBy"]?? 0,
    industryTypeId: json["IndustryTypeId"],
    industryType: json["IndustryType"]?? "No data",
    informationSourceId: json["InformationSourceId"],
    jobType: json["JobType"]?? 0,
    organizationTypeId: json["OrganizationTypeId"],
    campaignId: json["CampaignId"],
    priority: json["Priority"]?? 0,
    isPrimary: json["IsPrimary"],
    interestedItems: json["InterestedItems"],
    latitude: json["Latitude"]?.toDouble(),
    longitude: json["Longitude"]?.toDouble(),
    prospectStage: json["ProspectStage"]?? 0,
    stage: json["Stage"],
    prospectStageDate: json["ProspectStageDate"] == null ? null : DateTime.parse(json["ProspectStageDate"]),
    changeDate: DateTime.parse(json["ChangeDate"]),
    note: json["Note"],
    prospectIds: json["ProspectIds"],
    totalCount: json["TotalCount"],
    projectId: json["ProjectId"],
    canEdit: json["CanEdit"],
    canDelete: json["CanDelete"],
    canView: json["CanView"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Code": code,
    "smsType": smsType,
    "ContactNumber": contactNumber,
    "DesignationId": designationId,
    "DesignationName": designationName,
    "Email": email,
    "ConcernPersons": concernPersons == null ? [] : List<dynamic>.from(concernPersons!.map((x) => x.toJson())),
    "ConcernPersonsJSON": concernPersonsJson,
    "DateOfBirth": dateOfBirth?.toIso8601String(),
    "CreatedOn": createdOn.toIso8601String(),
    "IsIndividual": isIndividual,
    "Type": type,
    "LeadCount": leadCount,
    "QuoteCount": quoteCount,
    "OrderCount": orderCount,
    "TaskCount": taskCount,
    "Followup_CallCount": followupCallCount,
    "Followup_EmailCount": followupEmailCount,
    "Followup_MeetingCount": followupMeetingCount,
    "Followup_VisitCount": followupVisitCount,
    "LastFlwDate": lastFlwDate?.toIso8601String(),
    "LastFlwBy": lastFlwBy,
    "WebsiteProspect": websiteProspect,
    "CreatedByName": createdByName,
    "CreatedBy": createdBy,
    "AssignToEmployeeId": assignToEmployeeId,
    "AssignToEmployee":assignToEmployee,
    "ZoneID": zoneId,
    "ZoneName": zoneName,
    "ConnectedBy": connectedBy,
    "IndustryTypeId": industryTypeId,
    "IndustryType": industryType,
    "InformationSourceId": informationSourceId,
    "JobType": jobType,
    "OrganizationTypeId": organizationTypeId,
    "CampaignId": campaignId,
    "Priority": priority,
    "IsPrimary": isPrimary,
    "InterestedItems": interestedItems,
    "Latitude": latitude,
    "Longitude": longitude,
    "ProspectStage": prospectStage,
    "Stage": stage,
    "ProspectStageDate": prospectStageDate?.toIso8601String(),
    "ChangeDate": changeDate.toIso8601String(),
    "Note": note,
    "ProspectIds": prospectIds,
    "TotalCount": totalCount,
    "ProjectId": projectId,
    "CanEdit": canEdit,
    "CanDelete": canDelete,
    "CanView": canView,
  };
}

enum LastFlwBy {
  AFIA_FARZANA_SHARMEE,
  AL_NAHIAN,
  EVA_SHARMIN_JEBA,
  IFTTI_SHARIAR_FAHIM,
  IRTISHAM_RAHMAN_OISHY,
  KAZI_ESTIAKE_AHMED,
  KAZI_MD_RAISE_UDDIN,
  KEYA_YEASAMIN,
  KH_AHMED_IMTIAZ_MAHMOOD,
  MD_ANWAR_HUSAIN,
  MD_ASADULLAH,
  MD_FAZLE_RABBI,
  MD_HABIBUR_RAHMAN,
  MD_MAZHARUL_ALAM_BHUYAIN,
  MD_MUHIBUL_HASAN,
  MD_RAFIQUL_ISLAM,
  MD_RAYHAN_UDDEN,
  MD_SHAHNEAWS_KHAN_RAHI,
  MD_ZIAUL_OSMAN,
  MIR_FAHIM_RAHMAN,
  MOHAMMAD_KAMAL_HOSSAIN,
  MOHAMMAD_MYDUL_ISLAM,
  MOHAMMAD_SHIBLI_SHADIK,
  MUHAMMAD_HASIBUR_RAHMAN,
  MUHAMMED_MAHFUZUR_RAHMAN,
  MUQTADER_AHMED,
  NAZRIN_ISLAM,
  NO_FOLLOWUP,
  NYMUR_RAHMAN,
  OLIULLAH_ASHRAFI,
  ROJINA_KHATUN,
  SAAD_MOHAMMAD,
  SANJIDA_AFRIN,
  SHANJIDA,
  SORKER_SONET,
  SUPER_ADMIN,
  SUVONKOR_MALAKAR,
  TANAY_CHANDRA_DAS,
  TASNIM_FERDOUSI,
  ZAHIDUL_ISLAM_EMON
}



class ConcernPerson {
  String contactpersonName;
  String contactpersonDesignation;
  String contactpersonMobile;
  String contactpersonEmail;
  bool isPrimary;

  ConcernPerson({
    required this.contactpersonName,
    required this.contactpersonDesignation,
    required this.contactpersonMobile,
    required this.contactpersonEmail,
    required this.isPrimary,
  });

  factory ConcernPerson.fromJson(Map<String, dynamic> json) => ConcernPerson(
    contactpersonName: json["ContactpersonName"],
    contactpersonDesignation: json["ContactpersonDesignation"],
    contactpersonMobile: json["ContactpersonMobile"],
    contactpersonEmail: json["ContactpersonEmail"],
    isPrimary: json["IsPrimary"],
  );

  Map<String, dynamic> toJson() => {
    "ContactpersonName": contactpersonName,
    "ContactpersonDesignation": contactpersonDesignation,
    "ContactpersonMobile": contactpersonMobile,
    "ContactpersonEmail": contactpersonEmail,
    "IsPrimary": isPrimary,
  };
}




enum Stage {
  ALREADY_CLIENT,
  ALREADY_HAVE_CRM,
  COULDN_T_REACH,
  DEMO_ACCOUNT,
  DEMO_DONE,
  ERP_ACP,
  FUTURE_PROSPECT,
  HOT_LEADS,
  INITIAL_CONTACT,
  INVALID_NUMBER,
  LEAD_CREATED,
  NEW_PROSPECT,
  NO_NEED_SOFTWARE,
  ON_FOLLOWUP,
  RECYCLE_BIN,
  VISITED
}



class StageCount {
  int stageId;
  String? stageName;
  String color;
  int prospect;
  bool isSelected;

  StageCount({
    required this.stageId,
    required this.stageName,
    required this.color,
    required this.prospect,
    required this.isSelected,
  });

  factory StageCount.fromJson(Map<String, dynamic> json) => StageCount(
    stageId: json["StageId"],
    stageName: json["StageName"],
    color: json["Color"],
    prospect: json["Prospect"],
    isSelected: json["IsSelected"],
  );

  Map<String, dynamic> toJson() => {
    "StageId": stageId,
    "StageName": stageName,
    "Color": color,
    "Prospect": prospect,
    "IsSelected": isSelected,
  };
}

