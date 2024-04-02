// To parse this JSON data, do
//
//     final myAttenRepByMonthModel = myAttenRepByMonthModelFromJson(jsonString);

import 'dart:convert';

MyAttenRepByMonthModel myAttenRepByMonthModelFromJson(String str) => MyAttenRepByMonthModel.fromJson(json.decode(str));

String myAttenRepByMonthModelToJson(MyAttenRepByMonthModel data) => json.encode(data.toJson());

class MyAttenRepByMonthModel {
  String? message;
  List<Result>? result;
  bool? isSuccess;

  MyAttenRepByMonthModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory MyAttenRepByMonthModel.fromJson(Map<String, dynamic> json) => MyAttenRepByMonthModel(
    message: json["Message"],
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class Result {
  int id;
  int employeeId;
  DateTime logTimeIn;
  DateTime? logTimeOut;
  bool isLogIn;
  bool isLogFromPhone;
  double latitude;
  double longitude;
  String locationDescription;
  String remark;
  bool isLate;
  bool isEarlyOut;
  bool isHalfDay;
  bool isExtremeLate;
  bool isExtremeEarlyOut;
  double? latitudeOut;
  double? longitudeOut;
  String? locationDescriptionOut;
  String? batteryStatus;
  int absent;
  int onLeave;
  int workingDays;
  int onTime;
  String? checkInNote;
  String? checkOutNote;
  dynamic token;
  dynamic hours;
  dynamic overTime;
  bool active;
  int createdBy;
  DateTime createdOn;
  int updatedBy;
  DateTime updatedOn;
  bool isDeleted;

  Result({
    required this.id,
    required this.employeeId,
    required this.logTimeIn,
    required this.logTimeOut,
    required this.isLogIn,
    required this.isLogFromPhone,
    required this.latitude,
    required this.longitude,
    required this.locationDescription,
    required this.remark,
    required this.isLate,
    required this.isEarlyOut,
    required this.isHalfDay,
    required this.isExtremeLate,
    required this.isExtremeEarlyOut,
    required this.latitudeOut,
    required this.longitudeOut,
    required this.locationDescriptionOut,
    required this.batteryStatus,
    required this.absent,
    required this.onLeave,
    required this.workingDays,
    required this.onTime,
    required this.checkInNote,
    required this.checkOutNote,
    required this.token,
    required this.hours,
    required this.overTime,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.isDeleted,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    employeeId: json["EmployeeId"],
    logTimeIn: DateTime.parse(json["LogTimeIn"]),
    logTimeOut: json["LogTimeOut"] == null ? DateTime.parse("2024-03-07T09:06:13.489Z") : DateTime.parse(json["LogTimeOut"]),
    isLogIn: json["IsLogIn"],
    isLogFromPhone: json["IsLogFromPhone"],
    latitude: json["Latitude"] ?? 0.0,
    longitude: json["Longitude"]?? 0.0,
    locationDescription: json["LocationDescription"] ??"No Data",
    remark:json["Remark"]?? "No Data",
    isLate: json["IsLate"] ?? false,
    isEarlyOut: json["IsEarlyOut"]  ?? false,
    isHalfDay: json["IsHalfDay"]?? false,
    isExtremeLate: json["IsExtremeLate"]?? false,
    isExtremeEarlyOut: json["IsExtremeEarlyOut"]?? false,
    latitudeOut: json["LatitudeOut"]?.toDouble(),
    longitudeOut: json["LongitudeOut"]?.toDouble(),
    locationDescriptionOut: json["LocationDescriptionOut"],
    batteryStatus: json["BatteryStatus"] ?? "",
    absent: json["Absent"]??0,
    onLeave: json["OnLeave"]??0,
    workingDays: json["WorkingDays"]??0,
    onTime: json["OnTime"]??0,
    checkInNote: json["CheckInNote"]??"No Data",
    checkOutNote: json["CheckOutNote"]??"No Data",
    token: json["Token"],
    hours: json["Hours"],
    overTime: json["OverTime"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"]??0,
    updatedOn: json["UpdatedOn"] == null ?DateTime.parse(DateTime.now().toString()) :DateTime.parse(json["UpdatedOn"]),
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "EmployeeId": employeeId,
    "LogTimeIn": logTimeIn.toIso8601String(),
    "LogTimeOut": logTimeOut?.toIso8601String(),
    "IsLogIn": isLogIn,
    "IsLogFromPhone": isLogFromPhone,
    "Latitude": latitude,
    "Longitude": longitude,
    "LocationDescription": locationDescription,
    "Remark": remark,
    "IsLate": isLate,
    "IsEarlyOut": isEarlyOut,
    "IsHalfDay": isHalfDay,
    "IsExtremeLate": isExtremeLate,
    "IsExtremeEarlyOut": isExtremeEarlyOut,
    "LatitudeOut": latitudeOut,
    "LongitudeOut": longitudeOut,
    "LocationDescriptionOut": locationDescriptionOut,
    "BatteryStatus": batteryStatusValues.reverse[batteryStatus],
    "Absent": absent,
    "OnLeave": onLeave,
    "WorkingDays": workingDays,
    "OnTime": onTime,
    "CheckInNote": batteryStatusValues.reverse[checkInNote],
    "CheckOutNote": checkOutNote,
    "Token": token,
    "Hours": hours,
    "OverTime": overTime,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn.toIso8601String(),
    "IsDeleted": isDeleted,
  };
}

enum BatteryStatus {
  STRING
}

final batteryStatusValues = EnumValues({
  "string": BatteryStatus.STRING
});

enum Remark {
  EMPTY,
  RAIN,
  TRAFFIC_CONGESTION
}

final remarkValues = EnumValues({
  "": Remark.EMPTY,
  "rain": Remark.RAIN,
  "Traffic congestion": Remark.TRAFFIC_CONGESTION
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
